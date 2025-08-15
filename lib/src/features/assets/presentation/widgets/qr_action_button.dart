import 'package:flutter/material.dart';

/// Tipos de botones de acción para QR
enum QrActionButtonType {
  /// Botón primario (azul)
  primary,
  /// Botón secundario (gris)
  secondary,
  /// Botón con borde (outline)
  outline,
}

/// Widget de botón personalizado para acciones de QR
class QrActionButton extends StatelessWidget {
  /// Constructor del botón de acción QR
  const QrActionButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.isLoading = false,
    this.type = QrActionButtonType.primary,
    this.width,
    this.height = 48.0,
  });

  /// Función a ejecutar cuando se presiona el botón
  final VoidCallback? onPressed;
  
  /// Texto del botón
  final String text;
  
  /// Icono del botón
  final IconData icon;
  
  /// Si el botón está en estado de carga
  final bool isLoading;
  
  /// Tipo de botón
  final QrActionButtonType type;
  
  /// Ancho del botón
  final double? width;
  
  /// Alto del botón
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Configuración de colores según el tipo
    Color backgroundColor;
    Color foregroundColor;
    Color? borderColor;
    
    switch (type) {
      case QrActionButtonType.primary:
        backgroundColor = theme.primaryColor;
        foregroundColor = Colors.white;
        borderColor = null;
        break;
      case QrActionButtonType.secondary:
        backgroundColor = Colors.grey[600]!;
        foregroundColor = Colors.white;
        borderColor = null;
        break;
      case QrActionButtonType.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = theme.primaryColor;
        borderColor = theme.primaryColor;
        break;
    }
    
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          side: borderColor != null ? BorderSide(color: borderColor) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: type == QrActionButtonType.outline ? 0 : 2,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
        icon: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
                ),
              )
            : Icon(
                icon,
                size: 20,
              ),
        label: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}