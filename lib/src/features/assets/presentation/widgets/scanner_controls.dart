import 'package:flutter/material.dart';

/// Widget que muestra los controles del escáner de QR
class ScannerControls extends StatelessWidget {
  /// Constructor de los controles del escáner
  const ScannerControls({
    super.key,
    required this.isScanning,
    required this.onToggleFlash,
    required this.onSwitchCamera,
    required this.onResumeScan,
  });

  /// Si el escáner está activo
  final bool isScanning;
  
  /// Función para alternar el flash
  final VoidCallback onToggleFlash;
  
  /// Función para cambiar de cámara
  final VoidCallback onSwitchCamera;
  
  /// Función para reanudar el escaneo
  final VoidCallback onResumeScan;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withValues(alpha: 0.8),
          ],
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Botones de control
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlButton(
                  context: context,
                  icon: Icons.flash_on,
                  label: 'Flash',
                  onPressed: isScanning ? onToggleFlash : null,
                ),
                _buildControlButton(
                  context: context,
                  icon: Icons.flip_camera_ios,
                  label: 'Cámara',
                  onPressed: isScanning ? onSwitchCamera : null,
                ),
                if (!isScanning)
                  _buildControlButton(
                    context: context,
                    icon: Icons.play_arrow,
                    label: 'Reanudar',
                    onPressed: onResumeScan,
                    isPrimary: true,
                  ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Indicador de estado
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isScanning 
                    ? Colors.green.withValues(alpha: 0.2)
                    : Colors.orange.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isScanning ? Colors.green : Colors.orange,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isScanning ? Icons.qr_code_scanner : Icons.pause,
                    color: isScanning ? Colors.green : Colors.orange,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isScanning ? 'Escaneando...' : 'Pausado',
                    style: TextStyle(
                      color: isScanning ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  /// Construye un botón de control
  Widget _buildControlButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    bool isPrimary = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: isPrimary 
                ? Theme.of(context).primaryColor
                : Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isPrimary 
                  ? Theme.of(context).primaryColor
                  : Colors.white.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: isPrimary ? Colors.white : Colors.white,
              size: 28,
            ),
            splashRadius: 30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: onPressed != null ? Colors.white : Colors.white54,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
  

}