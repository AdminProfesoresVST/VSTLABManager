import 'package:flutter/material.dart';

/// Tipos de botón para formularios de activos
enum AssetFormButtonType {
  /// Botón primario (acción principal)
  primary,
  /// Botón secundario (acción secundaria)
  secondary,
  /// Botón de peligro (acciones destructivas)
  danger,
}

/// Widget personalizado para botones de formulario de activos
class AssetFormButton extends StatelessWidget {
  /// Constructor del botón de formulario
  const AssetFormButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.type = AssetFormButtonType.primary,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height = 48,
  });

  /// Función a ejecutar cuando se presiona el botón
  final VoidCallback? onPressed;
  
  /// Texto del botón
  final String text;
  
  /// Tipo de botón
  final AssetFormButtonType type;
  
  /// Indica si el botón está en estado de carga
  final bool isLoading;
  
  /// Icono del botón (opcional)
  final IconData? icon;
  
  /// Ancho del botón (opcional)
  final double? width;
  
  /// Alto del botón
  final double height;

  /// Obtiene el color de fondo según el tipo de botón
  Color _getBackgroundColor(BuildContext context) {
    switch (type) {
      case AssetFormButtonType.primary:
        return Theme.of(context).primaryColor;
      case AssetFormButtonType.secondary:
        return Colors.grey[100]!;
      case AssetFormButtonType.danger:
        return Colors.red[600]!;
    }
  }

  /// Obtiene el color del texto según el tipo de botón
  Color _getTextColor(BuildContext context) {
    switch (type) {
      case AssetFormButtonType.primary:
        return Colors.white;
      case AssetFormButtonType.secondary:
        return Colors.grey[700]!;
      case AssetFormButtonType.danger:
        return Colors.white;
    }
  }

  /// Obtiene el color del borde según el tipo de botón
  Color _getBorderColor(BuildContext context) {
    switch (type) {
      case AssetFormButtonType.primary:
        return Theme.of(context).primaryColor;
      case AssetFormButtonType.secondary:
        return Colors.grey[300]!;
      case AssetFormButtonType.danger:
        return Colors.red[600]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _getBackgroundColor(context),
          foregroundColor: _getTextColor(context),
          side: BorderSide(
            color: _getBorderColor(context),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: type == AssetFormButtonType.primary ? 2 : 0,
          shadowColor: type == AssetFormButtonType.primary 
              ? Theme.of(context).primaryColor.withOpacity(0.3)
              : null,
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getTextColor(context),
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}