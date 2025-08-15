import 'package:flutter/material.dart';

/// Tipos de SnackBar disponibles
enum SnackBarType {
  success,
  error,
  warning,
  info,
}

/// SnackBar personalizado con diferentes tipos y estilos
class CustomSnackbar {
  /// Muestra un SnackBar de éxito
  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _showSnackBar(
      context,
      message,
      SnackBarType.success,
      duration: duration,
      action: action,
    );
  }

  /// Muestra un SnackBar de error
  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
  }) {
    _showSnackBar(
      context,
      message,
      SnackBarType.error,
      duration: duration,
      action: action,
    );
  }

  /// Muestra un SnackBar de advertencia
  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _showSnackBar(
      context,
      message,
      SnackBarType.warning,
      duration: duration,
      action: action,
    );
  }

  /// Muestra un SnackBar informativo
  static void showInfo(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _showSnackBar(
      context,
      message,
      SnackBarType.info,
      duration: duration,
      action: action,
    );
  }

  /// Método privado para mostrar el SnackBar
  static void _showSnackBar(
    BuildContext context,
    String message,
    SnackBarType type, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    final theme = Theme.of(context);
    final config = _getSnackBarConfig(type, theme);

    // Ocultar cualquier SnackBar existente
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            config.icon,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: config.backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(16),
      action: action,
      actionOverflowThreshold: 0.25,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Obtiene la configuración del SnackBar según el tipo
  static _SnackBarConfig _getSnackBarConfig(SnackBarType type, ThemeData theme) {
    switch (type) {
      case SnackBarType.success:
        return _SnackBarConfig(
          backgroundColor: Colors.green[600]!,
          icon: Icons.check_circle,
        );
      case SnackBarType.error:
        return _SnackBarConfig(
          backgroundColor: Colors.red[600]!,
          icon: Icons.error,
        );
      case SnackBarType.warning:
        return _SnackBarConfig(
          backgroundColor: Colors.orange[600]!,
          icon: Icons.warning,
        );
      case SnackBarType.info:
        return _SnackBarConfig(
          backgroundColor: theme.primaryColor,
          icon: Icons.info,
        );
    }
  }
}

/// Configuración interna del SnackBar
class _SnackBarConfig {
  final Color backgroundColor;
  final IconData icon;

  _SnackBarConfig({
    required this.backgroundColor,
    required this.icon,
  });
}

/// Widget personalizado para mostrar mensajes inline
class CustomMessage extends StatelessWidget {
  final String message;
  final SnackBarType type;
  final VoidCallback? onDismiss;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const CustomMessage({
    super.key,
    required this.message,
    required this.type,
    this.onDismiss,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final config = CustomSnackbar._getSnackBarConfig(type, theme);

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: config.backgroundColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: config.backgroundColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            config.icon,
            color: config.backgroundColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: config.backgroundColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (onDismiss != null) ...[
            const SizedBox(width: 8),
            InkWell(
              onTap: onDismiss,
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.close,
                  color: config.backgroundColor,
                  size: 16,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}