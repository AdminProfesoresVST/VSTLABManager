import 'package:flutter/material.dart';

/// Widget personalizado para botones de autenticación
class AuthButton extends StatelessWidget {
  /// Función que se ejecuta al presionar el botón
  final VoidCallback? onPressed;
  
  /// Texto del botón
  final String text;
  
  /// Si el botón está en estado de carga
  final bool isLoading;
  
  /// Tipo de botón (primario o secundario)
  final AuthButtonType type;
  
  /// Icono opcional del botón
  final IconData? icon;

  /// Constructor del botón de autenticación
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.type = AuthButtonType.primary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: type == AuthButtonType.primary
              ? theme.primaryColor
              : Colors.white,
          foregroundColor: type == AuthButtonType.primary
              ? Colors.white
              : theme.primaryColor,
          elevation: type == AuthButtonType.primary ? 2 : 0,
          side: type == AuthButtonType.secondary
              ? BorderSide(color: theme.primaryColor, width: 1.5)
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBackgroundColor: Colors.grey[300],
          disabledForegroundColor: Colors.grey[600],
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    type == AuthButtonType.primary
                        ? Colors.white
                        : theme.primaryColor,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
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

/// Tipos de botón de autenticación
enum AuthButtonType {
  /// Botón primario (fondo de color)
  primary,
  
  /// Botón secundario (borde de color)
  secondary,
}