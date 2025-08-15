import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/loan_providers.dart';
import '../widgets/loan_return_modal.dart';
import '../../domain/entities/loan.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/loading_overlay.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_snackbar.dart';

/// Pantalla para mostrar préstamos activos
class ActiveLoansScreen extends ConsumerWidget {
  /// Constructor de la pantalla de préstamos activos
  const ActiveLoansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeLoansAsync = ref.watch(activeLoansProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const CustomAppBar(
        title: 'Préstamos Activos',
      ),
      body: activeLoansAsync.when(
        data: (loans) => _buildLoansList(context, ref, loans),
        loading: () => const LoadingOverlay(
          isLoading: true,
          message: 'Cargando préstamos...',
          child: SizedBox.expand(),
        ),
        error: (error, stack) => _buildErrorState(context, ref, error),
      ),
    );
  }

  Widget _buildLoansList(BuildContext context, WidgetRef ref, List<Loan> loans) {
    if (loans.isEmpty) {
      return _buildEmptyState(context);
    }

    return RefreshIndicator(
      onRefresh: () => ref.refresh(activeLoansProvider.future),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: loans.length,
        itemBuilder: (context, index) {
          final loan = loans[index];
          return _buildLoanCard(context, ref, loan);
        },
      ),
    );
  }

  Widget _buildLoanCard(BuildContext context, WidgetRef ref, Loan loan) {
    final isOverdue = loan.isOverdue;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isOverdue ? Colors.red[300]! : Colors.transparent,
          width: isOverdue ? 2 : 0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLoanHeader(loan, isOverdue),
            const SizedBox(height: 12),
            _buildLoanDetails(loan),
            const SizedBox(height: 16),
            _buildLoanActions(context, ref, loan),
          ],
        ),
      ),
    );
  }

  Widget _buildLoanHeader(Loan loan, bool isOverdue) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isOverdue ? Colors.red[100] : Colors.blue[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            isOverdue ? Icons.warning : Icons.assignment,
            color: isOverdue ? Colors.red[600] : Colors.blue[600],
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Préstamo ${loan.id.substring(0, 8)}...',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (isOverdue)
                Text(
                  'Vencido hace ${loan.daysOverdue} días',
                  style: TextStyle(
                    color: Colors.red[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
        _buildStatusChip(loan.status, isOverdue),
      ],
    );
  }

  Widget _buildStatusChip(String status, bool isOverdue) {
    Color backgroundColor;
    Color textColor;
    String displayText;

    if (isOverdue) {
      backgroundColor = Colors.red[100]!;
      textColor = Colors.red[700]!;
      displayText = 'Vencido';
    } else {
      backgroundColor = Colors.green[100]!;
      textColor = Colors.green[700]!;
      displayText = 'Activo';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildLoanDetails(Loan loan) {
    return Column(
      children: [
        _buildDetailRow(
          icon: Icons.inventory_2_outlined,
          label: 'Activo ID',
          value: loan.assetId,
        ),
        const SizedBox(height: 8),
        _buildDetailRow(
          icon: Icons.person_outline,
          label: 'Responsable ID',
          value: loan.borrowerId,
        ),
        const SizedBox(height: 8),
        _buildDetailRow(
          icon: Icons.calendar_today_outlined,
          label: 'Fecha de Préstamo',
          value: _formatDate(loan.startDate),
        ),
        const SizedBox(height: 8),
        _buildDetailRow(
          icon: Icons.event_outlined,
          label: 'Fecha Esperada',
          value: _formatDate(loan.expectedReturnDate),
        ),
        if (loan.notes != null && loan.notes!.isNotEmpty) ...[
          const SizedBox(height: 8),
          _buildDetailRow(
            icon: Icons.note_outlined,
            label: 'Notas',
            value: loan.notes!,
          ),
        ],
      ],
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoanActions(BuildContext context, WidgetRef ref, Loan loan) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'Ver Detalles',
            type: CustomButtonType.outline,
            onPressed: () {
              // TODO: Navegar a detalles del préstamo
              CustomSnackbar.showInfo(
                context,
                'Funcionalidad de detalles en desarrollo',
              );
            },
            icon: const Icon(Icons.visibility, size: 16),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: CustomButton(
            text: 'Registrar Devolución',
            type: CustomButtonType.primary,
            onPressed: () => _showReturnModal(context, ref, loan),
            icon: const Icon(Icons.assignment_return, size: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              'No hay préstamos activos',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Todos los activos están disponibles o no hay préstamos registrados.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, Object error) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red[400],
            ),
            const SizedBox(height: 24),
            Text(
              'Error al cargar préstamos',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.red[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              error.toString(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Reintentar',
              type: CustomButtonType.primary,
              onPressed: () {
              ref.refresh(activeLoansProvider);
            },
              icon: const Icon(Icons.refresh, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _showReturnModal(BuildContext context, WidgetRef ref, Loan loan) {
    LoanReturnModal.show(
      context: context,
      loan: loan,
      onReturnSuccess: () {
        // Refrescar la lista de préstamos activos
        ref.refresh(activeLoansProvider);
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}