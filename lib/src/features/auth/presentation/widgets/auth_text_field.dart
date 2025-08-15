import 'package:flutter/material.dart';

/// Widget personalizado para campos de texto de autenticación
class AuthTextField extends StatelessWidget {
  /// Controller del campo de texto
  final TextEditingController controller;
  
  /// Etiqueta del campo
  final String label;
  
  /// Tipo de teclado
  final TextInputType? keyboardType;
  
  /// Icono de prefijo
  final IconData? prefixIcon;
  
  /// Widget de sufijo personalizado
  final Widget? suffixIcon;
  
  /// Si el texto debe estar oculto
  final bool obscureText;
  
  /// Función de validación
  final String? Function(String?)? validator;
  
  /// Texto de ayuda
  final String? helperText;
  
  /// Si el campo está habilitado
  final bool enabled;

  /// Constructor del campo de texto de autenticación
  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.helperText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      enabled: enabled,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        helperText: helperText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      style: TextStyle(
        fontSize: 16,
        color: enabled ? Colors.black87 : Colors.grey[600],
      ),
    );
  }
}