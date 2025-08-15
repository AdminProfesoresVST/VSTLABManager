import 'package:flutter/material.dart';

/// Tipos de botón disponibles
enum CustomButtonType {
  primary,
  secondary,
  outline,
  text,
  danger,
}

/// Tamaños de botón disponibles
enum CustomButtonSize {
  small,
  medium,
  large,
}

/// Botón personalizado reutilizable
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final CustomButtonType type;
  final CustomButtonSize size;
  final Widget? icon;
  final bool isLoading;
  final bool isFullWidth;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = CustomButtonType.primary,
    this.size = CustomButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonStyle = _getButtonStyle(theme);
    final textStyle = _getTextStyle(theme);
    final buttonPadding = padding ?? _getPadding();
    final buttonBorderRadius = borderRadius ?? _getBorderRadius();

    Widget button;

    switch (type) {
      case CustomButtonType.primary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonStyle.backgroundColor,
            foregroundColor: buttonStyle.foregroundColor,
            padding: buttonPadding,
            shape: RoundedRectangleBorder(
              borderRadius: buttonBorderRadius,
            ),
            elevation: 2,
          ),
          child: _buildButtonContent(textStyle),
        );
        break;
      case CustomButtonType.secondary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonStyle.backgroundColor,
            foregroundColor: buttonStyle.foregroundColor,
            padding: buttonPadding,
            shape: RoundedRectangleBorder(
              borderRadius: buttonBorderRadius,
            ),
            elevation: 1,
          ),
          child: _buildButtonContent(textStyle),
        );
        break;
      case CustomButtonType.outline:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: buttonStyle.foregroundColor,
            padding: buttonPadding,
            shape: RoundedRectangleBorder(
              borderRadius: buttonBorderRadius,
            ),
            side: BorderSide(
              color: buttonStyle.borderColor ?? theme.primaryColor,
              width: 1.5,
            ),
          ),
          child: _buildButtonContent(textStyle),
        );
        break;
      case CustomButtonType.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: buttonStyle.foregroundColor,
            padding: buttonPadding,
            shape: RoundedRectangleBorder(
              borderRadius: buttonBorderRadius,
            ),
          ),
          child: _buildButtonContent(textStyle),
        );
        break;
      case CustomButtonType.danger:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonStyle.backgroundColor,
            foregroundColor: buttonStyle.foregroundColor,
            padding: buttonPadding,
            shape: RoundedRectangleBorder(
              borderRadius: buttonBorderRadius,
            ),
            elevation: 2,
          ),
          child: _buildButtonContent(textStyle),
        );
        break;
    }

    return isFullWidth
        ? SizedBox(
            width: double.infinity,
            child: button,
          )
        : button;
  }

  Widget _buildButtonContent(TextStyle textStyle) {
    if (isLoading) {
      return SizedBox(
        height: _getIconSize(),
        width: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: textStyle.color,
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          Text(text, style: textStyle),
        ],
      );
    }

    return Text(text, style: textStyle);
  }

  _ButtonStyle _getButtonStyle(ThemeData theme) {
    switch (type) {
      case CustomButtonType.primary:
        return _ButtonStyle(
          backgroundColor: theme.primaryColor,
          foregroundColor: Colors.white,
        );
      case CustomButtonType.secondary:
        return _ButtonStyle(
          backgroundColor: theme.cardColor,
          foregroundColor: theme.textTheme.bodyLarge?.color,
        );
      case CustomButtonType.outline:
        return _ButtonStyle(
          backgroundColor: Colors.transparent,
          foregroundColor: theme.primaryColor,
          borderColor: theme.primaryColor,
        );
      case CustomButtonType.text:
        return _ButtonStyle(
          backgroundColor: Colors.transparent,
          foregroundColor: theme.primaryColor,
        );
      case CustomButtonType.danger:
        return _ButtonStyle(
          backgroundColor: Colors.red[600],
          foregroundColor: Colors.white,
        );
    }
  }

  TextStyle _getTextStyle(ThemeData theme) {
    TextStyle baseStyle;
    switch (size) {
      case CustomButtonSize.small:
        baseStyle = theme.textTheme.bodySmall ?? const TextStyle();
        break;
      case CustomButtonSize.medium:
        baseStyle = theme.textTheme.bodyMedium ?? const TextStyle();
        break;
      case CustomButtonSize.large:
        baseStyle = theme.textTheme.bodyLarge ?? const TextStyle();
        break;
    }
    return baseStyle.copyWith(fontWeight: FontWeight.w600);
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case CustomButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case CustomButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal:16, vertical: 12);
      case CustomButtonSize.large:
        return const EdgeInsets.symmetric(horizontal:24, vertical: 16);
    }
  }

  BorderRadius _getBorderRadius() {
    switch (size) {
      case CustomButtonSize.small:
        return BorderRadius.circular(6);
      case CustomButtonSize.medium:
        return BorderRadius.circular(8);
      case CustomButtonSize.large:
        return BorderRadius.circular(10);
    }
  }

  double _getIconSize() {
    switch (size) {
      case CustomButtonSize.small:
        return 16;
      case CustomButtonSize.medium:
        return 18;
      case CustomButtonSize.large:
        return 20;
    }
  }
}

class _ButtonStyle {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;

  _ButtonStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  });
}