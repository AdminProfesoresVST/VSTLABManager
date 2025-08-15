import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../data/services/qr_service_impl.dart';
import '../../domain/entities/asset.dart';
import '../../domain/services/qr_service.dart';

/// Provider para el servicio de códigos QR
final qrServiceProvider = Provider<QrService>((ref) {
  return QrServiceImpl();
});

/// Estado para la gestión de códigos QR
class QrState {
  /// Constructor del estado QR
  const QrState({
    this.isGenerating = false,
    this.isSaving = false,
    this.isSharing = false,
    this.qrData,
    this.error,
    this.successMessage,
  });

  /// Indica si se está generando un código QR
  final bool isGenerating;
  
  /// Indica si se está guardando un código QR
  final bool isSaving;
  
  /// Indica si se está compartiendo un código QR
  final bool isSharing;
  
  /// Datos del código QR generado
  final String? qrData;
  
  /// Mensaje de error
  final String? error;
  
  /// Mensaje de éxito
  final String? successMessage;

  /// Copia el estado con nuevos valores
  QrState copyWith({
    bool? isGenerating,
    bool? isSaving,
    bool? isSharing,
    String? qrData,
    String? error,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return QrState(
      isGenerating: isGenerating ?? this.isGenerating,
      isSaving: isSaving ?? this.isSaving,
      isSharing: isSharing ?? this.isSharing,
      qrData: qrData ?? this.qrData,
      error: clearError ? null : (error ?? this.error),
      successMessage: clearSuccess ? null : (successMessage ?? this.successMessage),
    );
  }
}

/// Notificador para la gestión de códigos QR
class QrNotifier extends StateNotifier<QrState> {
  /// Constructor del notificador QR
  QrNotifier(this._qrService) : super(const QrState());

  final QrService _qrService;

  /// Genera un código QR para un activo
  void generateQrForAsset(Asset asset) {
    state = state.copyWith(isGenerating: true, clearError: true, clearSuccess: true);
    
    try {
      final qrData = _qrService.generateQrData(asset);
      state = state.copyWith(
        isGenerating: false,
        qrData: qrData,
        successMessage: 'Código QR generado exitosamente',
      );
    } catch (e) {
      state = state.copyWith(
        isGenerating: false,
        error: 'Error al generar el código QR: ${e.toString()}',
      );
    }
  }

  /// Guarda el código QR en la galería
  Future<bool> saveQrToGallery({
    required GlobalKey repaintBoundaryKey,
    required String fileName,
  }) async {
    state = state.copyWith(isSaving: true, clearError: true, clearSuccess: true);
    
    final result = await _qrService.saveQrToGallery(
      repaintBoundaryKey: repaintBoundaryKey,
      fileName: fileName,
    );
    
    if (result.isSuccess) {
      state = state.copyWith(
        isSaving: false,
        successMessage: result.data!,
      );
      return true;
    } else {
      state = state.copyWith(
        isSaving: false,
        error: result.exception?.message ?? 'Error al guardar el código QR',
      );
      return false;
    }
  }

  /// Comparte el código QR
  Future<bool> shareQr({
    required GlobalKey repaintBoundaryKey,
    required String fileName,
    String? text,
  }) async {
    state = state.copyWith(isSharing: true, clearError: true, clearSuccess: true);
    
    final result = await _qrService.shareQr(
      repaintBoundaryKey: repaintBoundaryKey,
      fileName: fileName,
      text: text,
    );
    
    if (result.isSuccess) {
      state = state.copyWith(
        isSharing: false,
        successMessage: 'Código QR compartido exitosamente',
      );
      return true;
    } else {
      state = state.copyWith(
        isSharing: false,
        error: result.exception?.message ?? 'Error al compartir el código QR',
      );
      return false;
    }
  }

  /// Valida si los datos del QR son válidos para un activo
  bool isValidAssetQrData(String qrData) {
    return _qrService.isValidAssetQrData(qrData);
  }

  /// Extrae el ID del activo desde los datos del QR
  String? extractAssetIdFromQrData(String qrData) {
    return _qrService.extractAssetIdFromQrData(qrData);
  }

  /// Limpia el estado
  void clearState() {
    state = const QrState();
  }

  /// Limpia solo los mensajes
  void clearMessages() {
    state = state.copyWith(clearError: true, clearSuccess: true);
  }
}

/// Provider para el notificador de códigos QR
final qrNotifierProvider = StateNotifierProvider<QrNotifier, QrState>((ref) {
  final qrService = ref.watch(qrServiceProvider);
  return QrNotifier(qrService);
});

/// Provider para verificar si hay un código QR generado
final hasQrDataProvider = Provider<bool>((ref) {
  final qrState = ref.watch(qrNotifierProvider);
  return qrState.qrData != null && qrState.qrData!.isNotEmpty;
});

/// Provider para verificar si hay alguna operación en progreso
final isQrBusyProvider = Provider<bool>((ref) {
  final qrState = ref.watch(qrNotifierProvider);
  return qrState.isGenerating || qrState.isSaving || qrState.isSharing;
});