import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/loan_providers.dart';
import '../../domain/entities/loan.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_snackbar.dart';

/// Modal para confirmar la devolución de un préstamo
class LoanReturnModal extends ConsumerStatefulWidget {
  final Loan loan;
  final VoidCallback? onReturnSuccess;

  const LoanReturnModal({
    super.key,
    required this.loan,
    this.onReturnSuccess,
  });

  @override
  ConsumerState<LoanReturnModal> createState() => _LoanReturnModalState();

  /// Método estático para mostrar el modal
  static Future<void> show({
    required BuildContext context,
    required Loan loan,
    VoidCallback? onReturnSuccess,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoanReturnModal(
        loan: loan,
        onReturnSuccess: onReturnSuccess,
      ),
    );
  }
}

class _LoanReturnModalState extends ConsumerState<LoanReturnModal> {
  final _notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final returnState = ref.watch(loanReturnProvider);
    final returnNotifier = ref.read(loanReturnProvider.notifier);

    // Escuchar cambios en el estado para mostrar mensajes
    ref.listen<LoanReturnState>(loanReturnProvider, (previous, current) {
      if (current.error != null) {
        CustomSnackbar.showError(context, current.error!);
      } else if (current.returnedLoan != null) {
        CustomSnackbar.showSuccess(
          context,
          'Activo devuelto exitosamente',
        );
        
        // Cerrar modal y ejecutar callback
        Navigator.of(context).pop();
        widget.onReturnSuccess?.call();
        
        // Limpiar estado
        returnNotifier.reset();
      }
    });

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(
            Icons.assignment_return,
            color: theme.primaryColor,
            size: 28,
          ),
          const SizedBox(width: 12),
          const Text('Confirmar Devolución'),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLoanInfo(),
              const SizedBox(height: 24),
              _buildNotesField(),
              const SizedBox(height: 16),
              _buildWarningMessage(),
            ],
          ),
        ),
      ),
      actions: [
        _buildCancelButton(),
        _buildConfirmButton(returnState, returnNotifier),
      ],
    );
  }

  Widget _buildLoanInfo() {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.blue[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Información del Préstamo',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoRow('ID del Préstamo:', widget.loan.id),
          _buildInfoRow('Activo ID:', widget.loan.assetId),
          _buildInfoRow(
            'Fecha de Préstamo:', 
            _formatDate(widget.loan.startDate),
          ),
          _buildInfoRow(
            'Fecha Esperada:', 
            _formatDate(widget.loan.expectedReturnDate),
          ),
          if (widget.loan.isOverdue)
            _buildOverdueWarning(),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverdueWarning() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.red[300]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning,
            color: Colors.red[600],
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Préstamo vencido hace ${widget.loan.daysOverdue} días',
              style: TextStyle(
                color: Colors.red[600],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notas de Devolución (Opcional)',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _notesController,
          maxLines: 3,
          maxLength: 500,
          decoration: InputDecoration(
            hintText: 'Agregar observaciones sobre la devolución...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
          onChanged: (value) {
            ref.read(loanReturnProvider.notifier).updateNotes(value);
          },
        ),
      ],
    );
  }

  Widget _buildWarningMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.orange[300]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.orange[600],
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Esta acción marcará el préstamo como devuelto y el activo estará disponible nuevamente.',
              style: TextStyle(
                color: Colors.orange[700],
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton() {
    return CustomButton(
      text: 'Cancelar',
      type: CustomButtonType.outline,
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  Widget _buildConfirmButton(
    LoanReturnState returnState,
    LoanReturnNotifier returnNotifier,
  ) {
    return CustomButton(
      text: 'Confirmar Devolución',
      type: CustomButtonType.primary,
      isLoading: returnState.isLoading,
      onPressed: returnState.isLoading
          ? null
          : () => returnNotifier.returnLoan(widget.loan.id),
      icon: const Icon(Icons.check, size: 18),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}