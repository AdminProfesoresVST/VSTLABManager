import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../domain/entities/asset.dart';
import '../providers/qr_providers.dart';
import '../widgets/qr_action_button.dart';

/// Pantalla para generar y gestionar códigos QR de activos
class QrGenerationScreen extends ConsumerStatefulWidget {
  /// Constructor de la pantalla de generación de QR
  const QrGenerationScreen({
    super.key,
    required this.asset,
  });

  /// Activo para el cual generar el código QR
  final Asset asset;

  @override
  ConsumerState<QrGenerationScreen> createState() => _QrGenerationScreenState();
}

class _QrGenerationScreenState extends ConsumerState<QrGenerationScreen> {
  final GlobalKey _qrKey = GlobalKey();
  
  @override
  void initState() {
    super.initState();
    // Generar el código QR al inicializar la pantalla
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(qrNotifierProvider.notifier).generateQrForAsset(widget.asset);
    });
  }

  @override
  void dispose() {
    // Limpiar el estado al salir
    ref.read(qrNotifierProvider.notifier).clearState();
    super.dispose();
  }

  /// Guarda el código QR en la galería
  Future<void> _saveQrToGallery() async {
    final fileName = 'QR_${widget.asset.name.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}';
    
    final success = await ref.read(qrNotifierProvider.notifier).saveQrToGallery(
      repaintBoundaryKey: _qrKey,
      fileName: fileName,
    );
    
    if (success && mounted) {
      _showSuccessSnackBar('Código QR guardado en la galería');
    }
  }

  /// Comparte el código QR
  Future<void> _shareQr() async {
    final fileName = 'QR_${widget.asset.name.replaceAll(' ', '_')}';
    final text = 'Código QR del activo: ${widget.asset.name}';
    
    final success = await ref.read(qrNotifierProvider.notifier).shareQr(
      repaintBoundaryKey: _qrKey,
      fileName: fileName,
      text: text,
    );
    
    if (success && mounted) {
      _showSuccessSnackBar('Código QR compartido exitosamente');
    }
  }

  /// Regenera el código QR
  void _regenerateQr() {
    ref.read(qrNotifierProvider.notifier).generateQrForAsset(widget.asset);
  }

  /// Muestra un SnackBar de éxito
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Muestra un SnackBar de error
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final qrState = ref.watch(qrNotifierProvider);
    
    // Mostrar mensajes de error o éxito
    ref.listen<QrState>(qrNotifierProvider, (previous, current) {
      if (current.error != null) {
        _showErrorSnackBar(current.error!);
      } else if (current.successMessage != null && 
                 current.successMessage != previous?.successMessage) {
        _showSuccessSnackBar(current.successMessage!);
      }
    });
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Código QR'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: qrState.isGenerating ? null : _regenerateQr,
            icon: const Icon(Icons.refresh),
            tooltip: 'Regenerar código QR',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Información del activo
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.inventory_2,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Información del Activo',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('Nombre:', widget.asset.name),
                    const SizedBox(height: 8),
                    _buildInfoRow('ID:', widget.asset.id),
                    const SizedBox(height: 8),
                    _buildInfoRow('Sucursal:', widget.asset.branchId),
                    const SizedBox(height: 8),
                    _buildInfoRow('Estado:', widget.asset.status),
                    const SizedBox(height: 8),
                    _buildInfoRow('Valor:', '\$${widget.asset.value.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Código QR
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Código QR',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    if (qrState.isGenerating)
                      const Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Generando código QR...'),
                          ],
                        ),
                      )
                    else if (qrState.qrData != null)
                      RepaintBoundary(
                        key: _qrKey,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.2),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: QrImageView(
                            data: qrState.qrData!,
                            version: QrVersions.auto,
                            size: 250.0,
                            backgroundColor: Colors.white,
                            errorCorrectionLevel: QrErrorCorrectLevel.M,
                            embeddedImage: null,
                            embeddedImageStyle: const QrEmbeddedImageStyle(
                              size: Size(40, 40),
                            ),
                            dataModuleStyle: const QrDataModuleStyle(
                              dataModuleShape: QrDataModuleShape.square,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    else
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.qr_code,
                                size: 64,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No se pudo generar el código QR',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Botones de acción
            if (qrState.qrData != null) ...[
              Row(
                children: [
                  Expanded(
                    child: QrActionButton(
                      onPressed: qrState.isSaving ? null : _saveQrToGallery,
                      text: 'Guardar',
                      icon: Icons.save,
                      isLoading: qrState.isSaving,
                      type: QrActionButtonType.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: QrActionButton(
                      onPressed: qrState.isSharing ? null : _shareQr,
                      text: 'Compartir',
                      icon: Icons.share,
                      isLoading: qrState.isSharing,
                      type: QrActionButtonType.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              QrActionButton(
                onPressed: qrState.isGenerating ? null : _regenerateQr,
                text: 'Regenerar Código QR',
                icon: Icons.refresh,
                isLoading: qrState.isGenerating,
                type: QrActionButtonType.outline,
              ),
            ],
            
            const SizedBox(height: 24),
            
            // Información adicional
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Información del Código QR',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '• El código QR contiene información única del activo\n'
                      '• Puede ser escaneado para acceder rápidamente a los detalles\n'
                      '• Se puede guardar en la galería o compartir con otros usuarios\n'
                      '• El código incluye validación de seguridad',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Construye una fila de información
  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}