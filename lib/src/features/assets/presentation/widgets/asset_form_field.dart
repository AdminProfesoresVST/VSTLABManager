import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget personalizado para campos de formulario de activos
class AssetFormField extends StatelessWidget {
  /// Constructor del campo de formulario
  const AssetFormField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.icon,
    this.isRequired = false,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.enabled = true,
    this.obscureText = false,
    this.inputFormatters,
    this.onChanged,
    this.suffixIcon,
  });

  /// Controlador del campo de texto
  final TextEditingController controller;
  
  /// Etiqueta del campo
  final String label;
  
  /// Texto de ayuda
  final String? hint;
  
  /// Icono del campo
  final IconData? icon;
  
  /// Indica si el campo es requerido
  final bool isRequired;
  
  /// Función de validación
  final String? Function(String?)? validator;
  
  /// Tipo de teclado
  final TextInputType? keyboardType;
  
  /// Número máximo de líneas
  final int maxLines;
  
  /// Indica si el campo está habilitado
  final bool enabled;
  
  /// Indica si el texto debe estar oculto
  final bool obscureText;
  
  /// Formateadores de entrada
  final List<TextInputFormatter>? inputFormatters;
  
  /// Callback cuando el texto cambia
  final void Function(String)? onChanged;
  
  /// Icono al final del campo
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Etiqueta del campo
        Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 20,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(
                  color: Colors.red[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        
        // Campo de texto
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          enabled: enabled,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey[300]!,
                width: 1.5,
              ),
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
              borderSide: BorderSide(
                color: Colors.red[400]!,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.red[600]!,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: enabled 
                ? Colors.grey[50] 
                : Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}