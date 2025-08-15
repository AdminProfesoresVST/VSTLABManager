import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../entities/asset.dart';
import '../../../../core/utils/result.dart';

/// Servicio abstracto para la gestión de códigos QR
abstract class QrService {
  /// Genera los datos del código QR para un activo
  String generateQrData(Asset asset);
  
  /// Guarda el código QR como imagen en la galería
  Future<Result<String>> saveQrToGallery({
    required GlobalKey repaintBoundaryKey,
    required String fileName,
  });
  
  /// Comparte el código QR
  Future<Result<void>> shareQr({
    required GlobalKey repaintBoundaryKey,
    required String fileName,
    String? text,
  });
  
  /// Convierte un widget a imagen
  Future<Result<Uint8List>> widgetToImage(GlobalKey repaintBoundaryKey);
  
  /// Valida si los datos del QR son válidos para un activo
  bool isValidAssetQrData(String qrData);
  
  /// Extrae el ID del activo desde los datos del QR
  String? extractAssetIdFromQrData(String qrData);
}