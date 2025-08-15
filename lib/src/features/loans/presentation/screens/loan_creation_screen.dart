import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/loan_providers.dart';
import '../widgets/asset_selector_widget.dart';
import '../widgets/borrower_selector_widget.dart';
import '../widgets/date_selector_widget.dart';
import '../widgets/notes_input_widget.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/loading_overlay.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_snackbar.dart';


/// Pantalla para crear un nuevo préstamo
class LoanCreationScreen extends ConsumerStatefulWidget {
  const LoanCreationScreen({super.key});

  @override
  ConsumerState<LoanCreationScreen> createState() => _LoanCreationScreenState();
}

class _LoanCreationScreenState extends ConsumerState<LoanCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loanState = ref.watch(loanCreationProvider);
    final loanNotifier = ref.read(loanCreationProvider.notifier);

    // Escuchar cambios en el estado para mostrar mensajes
    ref.listen<LoanCreationState>(loanCreationProvider, (previous, next) {
      if (next.error != null) {
        CustomSnackbar.showError(
          context,
          next.error!,
        );
      }

      if (next.createdLoan != null) {
        CustomSnackbar.showSuccess(
          context,
          'Préstamo creado exitosamente',
        );
        
        // Navegar de vuelta después de crear el préstamo
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted && context.mounted) {
            context.pop();
          }
        });
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(
        title: 'Nuevo Préstamo',

      ),
      body: LoadingOverlay(
        isLoading: loanState.isLoading,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildFormSection(
                  title: 'Activo a Prestar',
                  child: AssetSelectorWidget(
                    selectedAsset: loanState.selectedAsset,
                    onAssetSelected: loanNotifier.selectAsset,
                  ),
                ),
                const SizedBox(height: 24),
                _buildFormSection(
                  title: 'Responsable',
                  child: BorrowerSelectorWidget(
                    selectedBorrower: loanState.selectedBorrower,
                    onBorrowerSelected: loanNotifier.selectBorrower,
                  ),
                ),
                const SizedBox(height: 24),
                _buildFormSection(
                  title: 'Fecha de Devolución',
                  child: DateSelectorWidget(
                    selectedDate: loanState.selectedDate,
                    onDateSelected: loanNotifier.selectDate,
                  ),
                ),
                const SizedBox(height: 24),
                _buildFormSection(
                  title: 'Notas (Opcional)',
                  child: NotesInputWidget(
                    notes: loanState.notes ?? '',
                    onNotesChanged: loanNotifier.updateNotes,
                  ),
                ),
                const SizedBox(height: 32),
                _buildActionButtons(loanNotifier),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.primaryColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 48,
            color: theme.primaryColor,
          ),
          const SizedBox(height: 12),
          Text(
            'Crear Nuevo Préstamo',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Complete la información requerida para registrar un nuevo préstamo de activo.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: child,
        ),
      ],
    );
  }

  Widget _buildActionButtons(LoanCreationNotifier notifier) {
    final loanState = ref.watch(loanCreationProvider);
    final isFormValid = _isFormValid(loanState);

    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'Cancelar',
            type: CustomButtonType.outline,
            onPressed: loanState.isLoading ? null : () => context.pop(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: CustomButton(
            text: 'Crear Préstamo',
            onPressed: (isFormValid && !loanState.isLoading) ? () => notifier.createLoan() : null,
            type: CustomButtonType.primary,
            icon: const Icon(Icons.add_circle_outline, size: 18),
          ),
        ),
      ],
    );
  }

  bool _isFormValid(LoanCreationState state) {
    return state.selectedAsset != null &&
        state.selectedBorrower != null &&
        state.selectedDate != null;
  }
}