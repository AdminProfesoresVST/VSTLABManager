import 'package:flutter/material.dart';

/// Widget para ingresar notas adicionales del préstamo
class NotesInputWidget extends StatelessWidget {
  final String? notes;
  final Function(String) onNotesChanged;
  final String? errorText;

  const NotesInputWidget({
    super.key,
    this.notes,
    required this.onNotesChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notas adicionales',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: notes,
          onChanged: onNotesChanged,
          maxLines: 3,
          maxLength: 500,
          decoration: InputDecoration(
            hintText: 'Agregar notas sobre el préstamo (opcional)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.dividerColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.dividerColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: theme.primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.red[600]!,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.red[600]!,
                width: 2,
              ),
            ),
            errorText: errorText,
            filled: true,
            fillColor: theme.cardColor,
            contentPadding: const EdgeInsets.all(16),
            counterStyle: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          style: theme.textTheme.bodyLarge,
        ),
      ],
    );
  }
}