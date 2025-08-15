import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gal/gal.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import '../../domain/entities/asset.dart';
import '../../domain/services/qr_service.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/exceptions/app_exceptions.dart';

/// Implementación del servicio de códigos QR
class QrServiceImpl implements QrService {
  /// Prefijo para identificar códigos QR de activos
  static const String _qrPrefix = 'VSTLAB_ASSET:';

  @override
  String generateQrData(Asset asset) {
    final qrData = {
      'id': asset.id,
      'name': asset.name,
      'branchId': asset.branchId,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
    
    return '$_qrPrefix${jsonEncode(qrData)}';
  }

  @override
  Future<Result<String>> saveQrToGallery({
    required GlobalKey repaintBoundaryKey,
    required String fileName,
  }) async {
    try {
      // Solicitar permisos
      final permission = await _requestStoragePermission();
      if (!permission) {
        return Result.failure(
          const ValidationException(
            'Se requieren permisos de almacenamiento para guardar la imagen',
            code: 'PERMISSION_DENIED',
          ),
        );
      }

      // Convertir widget a imagen
      final imageResult = await widgetToImage(repaintBoundaryKey);
      if (imageResult.isFailure) {
        return Result.failure(imageResult.exception!);
      }

      // Guardar en galería
      await Gal.putImageBytes(
        imageResult.data!,
        name: fileName,
      );

      return Result.success('Código QR guardado en la galería');
    } catch (e) {
      return Result.failure(
        DatabaseException(
          'Error inesperado al guardar: ${e.toString()}',
          code: 'UNEXPECTED_ERROR',
        ),
      );
    }
  }

  @override
  Future<Result<void>> shareQr({
    required GlobalKey repaintBoundaryKey,
    required String fileName,
    String? text,
  }) async {
    try {
      // Convertir widget a imagen
      final imageResult = await widgetToImage(repaintBoundaryKey);
      if (imageResult.isFailure) {
        return Result.failure(imageResult.exception!);
      }

      // Crear archivo temporal
      final tempDir = Directory.systemTemp;
      final file = File('${tempDir.path}/$fileName.png');
      await file.writeAsBytes(imageResult.data!);

      // Compartir
      await Share.shareXFiles(
        [XFile(file.path)],
        text: text ?? 'Código QR del activo',
      );

      return Result.success(null);
    } catch (e) {
      return Result.failure(
        NetworkException(
          'Error al compartir el código QR: ${e.toString()}',
          code: 'SHARE_FAILED',
        ),
      );
    }
  }

  @override
  Future<Result<Uint8List>> widgetToImage(GlobalKey repaintBoundaryKey) async {
    try {
      final RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      
      final ui.Image image = await boundary.toImage(
        pixelRatio: 3.0, // Alta calidad
      );
      
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      
      if (byteData == null) {
        return Result.failure(
          const ValidationException(
            'Error al convertir el widget a imagen',
            code: 'CONVERSION_FAILED',
          ),
        );
      }
      
      return Result.success(byteData.buffer.asUint8List());
    } catch (e) {
      return Result.failure(
        ValidationException(
          'Error al capturar la imagen: ${e.toString()}',
          code: 'CAPTURE_FAILED',
        ),
      );
    }
  }

  @override
  bool isValidAssetQrData(String qrData) {
    if (!qrData.startsWith(_qrPrefix)) {
      return false;
    }
    
    try {
      final jsonData = qrData.substring(_qrPrefix.length);
      final data = jsonDecode(jsonData) as Map<String, dynamic>;
      
      return data.containsKey('id') && 
             data.containsKey('name') && 
             data.containsKey('branchId');
    } catch (e) {
      return false;
    }
  }

  @override
  String? extractAssetIdFromQrData(String qrData) {
    if (!isValidAssetQrData(qrData)) {
      return null;
    }
    
    try {
      final jsonData = qrData.substring(_qrPrefix.length);
      final data = jsonDecode(jsonData) as Map<String, dynamic>;
      return data['id'] as String?;
    } catch (e) {
      return null;
    }
  }

  /// Solicita permisos de almacenamiento
  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        await Gal.requestAccess();
        return await Gal.hasAccess();
      }
      return true;
    } else if (Platform.isIOS) {
      final hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        await Gal.requestAccess();
        return await Gal.hasAccess();
      }
      return true;
    }
    return true; // Para otras plataformas
  }
}