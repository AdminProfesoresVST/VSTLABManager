import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/loan.dart';
import '../../domain/repositories/loan_repository.dart';
import '../../data/repositories/loan_repository_sqlite.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/database/database_helper.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../assets/domain/entities/asset.dart';
import '../../../auth/domain/entities/app_user.dart';

/// Provider del repositorio de préstamos
final loanRepositoryProvider = Provider<LoanRepository>((ref) {
  return LoanRepositorySqlite(
    databaseHelper: DatabaseHelper.instance,
    uuid: const Uuid(),
  );
});

/// Estado para la creación de préstamos
class LoanCreationState {
  final bool isLoading;
  final String? error;
  final Loan? createdLoan;
  final Asset? selectedAsset;
  final AppUser? selectedBorrower;
  final DateTime? selectedDate;
  final String? notes;

  const LoanCreationState({
    this.isLoading = false,
    this.error,
    this.createdLoan,
    this.selectedAsset,
    this.selectedBorrower,
    this.selectedDate,
    this.notes,
  });

  LoanCreationState copyWith({
    bool? isLoading,
    String? error,
    Loan? createdLoan,
    Asset? selectedAsset,
    AppUser? selectedBorrower,
    DateTime? selectedDate,
    String? notes,
    bool clearError = false,
    bool clearCreatedLoan = false,
  }) {
    return LoanCreationState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      createdLoan: clearCreatedLoan ? null : (createdLoan ?? this.createdLoan),
      selectedAsset: selectedAsset ?? this.selectedAsset,
      selectedBorrower: selectedBorrower ?? this.selectedBorrower,
      selectedDate: selectedDate ?? this.selectedDate,
      notes: notes ?? this.notes,
    );
  }
}

/// Notifier para la creación de préstamos
class LoanCreationNotifier extends StateNotifier<LoanCreationState> {
  final LoanRepository _loanRepository;
  final Ref _ref;

  LoanCreationNotifier(this._loanRepository, this._ref) : super(const LoanCreationState());

  /// Selecciona un activo para el préstamo
  void selectAsset(Asset asset) {
    state = state.copyWith(selectedAsset: asset, clearError: true);
  }

  /// Selecciona un responsable para el préstamo
  void selectBorrower(AppUser borrower) {
    state = state.copyWith(selectedBorrower: borrower, clearError: true);
  }

  /// Selecciona la fecha de devolución
  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date, clearError: true);
  }

  /// Actualiza las notas del préstamo
  void updateNotes(String notes) {
    state = state.copyWith(notes: notes);
  }

  /// Crea un nuevo préstamo
  Future<void> createLoan() async {
    if (state.selectedAsset == null) {
      state = state.copyWith(error: 'Debe seleccionar un activo');
      return;
    }

    if (state.selectedBorrower == null) {
      state = state.copyWith(error: 'Debe seleccionar un responsable');
      return;
    }

    if (state.selectedDate == null) {
      state = state.copyWith(error: 'Debe seleccionar una fecha de devolución');
      return;
    }

    final currentUser = _ref.read(currentUserProvider);
    if (currentUser == null) {
      state = state.copyWith(error: 'Usuario no autenticado');
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _loanRepository.createLoan(
      assetId: state.selectedAsset!.id,
      borrowerId: state.selectedBorrower!.id,
      lenderId: currentUser.id,
      startDate: DateTime.now(),
      expectedReturnDate: state.selectedDate!,
      notes: state.notes?.isNotEmpty == true ? state.notes : null,
    );

    if (result.isSuccess) {
      state = state.copyWith(
        isLoading: false,
        createdLoan: result.data,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.exception?.message ?? 'Error al crear el préstamo',
      );
    }
  }

  /// Reinicia el estado
  void reset() {
    state = const LoanCreationState();
  }
}

/// Provider del notifier de creación de préstamos
final loanCreationProvider = StateNotifierProvider<LoanCreationNotifier, LoanCreationState>((ref) {
  final repository = ref.watch(loanRepositoryProvider);
  return LoanCreationNotifier(repository, ref);
});

/// Provider para obtener préstamos activos
final activeLoansProvider = FutureProvider<List<Loan>>((ref) async {
  final repository = ref.watch(loanRepositoryProvider);
  final result = await repository.getActiveLoans();
  
  if (result.isSuccess) {
    return result.data ?? [];
  } else {
    throw result.exception ?? Exception('Error al cargar préstamos activos');
  }
});

/// Provider para obtener préstamos vencidos
final overdueLoansProvider = FutureProvider<List<Loan>>((ref) async {
  final repository = ref.watch(loanRepositoryProvider);
  final result = await repository.getOverdueLoans();
  
  if (result.isSuccess) {
    return result.data ?? [];
  } else {
    throw result.exception ?? Exception('Error al cargar préstamos vencidos');
  }
});

/// Provider para obtener todos los préstamos
final allLoansProvider = FutureProvider<List<Loan>>((ref) async {
  final repository = ref.watch(loanRepositoryProvider);
  final result = await repository.getAllLoans();
  
  if (result.isSuccess) {
    return result.data ?? [];
  } else {
    throw result.exception ?? Exception('Error al cargar préstamos');
  }
});

/// Provider para obtener un préstamo por ID
final loanByIdProvider = FutureProvider.family<Loan?, String>((ref, loanId) async {
  final repository = ref.watch(loanRepositoryProvider);
  final result = await repository.getLoanById(loanId);
  
  if (result.isSuccess) {
    return result.data;
  } else {
    throw result.exception ?? Exception('Error al cargar el préstamo');
  }
});

/// Provider para obtener préstamos por activo
final loansByAssetProvider = FutureProvider.family<List<Loan>, String>((ref, assetId) async {
  final repository = ref.watch(loanRepositoryProvider);
  final result = await repository.getLoansByAsset(assetId);
  
  if (result.isSuccess) {
    return result.data ?? [];
  } else {
    throw result.exception ?? Exception('Error al cargar préstamos del activo');
  }
});

/// Provider para obtener el préstamo activo de un activo
final activeLoanByAssetProvider = FutureProvider.family<Loan?, String>((ref, assetId) async {
  final repository = ref.watch(loanRepositoryProvider);
  final result = await repository.getActiveLoanByAsset(assetId);
  
  if (result.isSuccess) {
    return result.data;
  } else {
    throw result.exception ?? Exception('Error al cargar préstamo activo');
  }
});

/// Estado para la devolución de préstamos
class LoanReturnState {
  final bool isLoading;
  final String? error;
  final Loan? returnedLoan;
  final String? notes;

  const LoanReturnState({
    this.isLoading = false,
    this.error,
    this.returnedLoan,
    this.notes,
  });

  LoanReturnState copyWith({
    bool? isLoading,
    String? error,
    Loan? returnedLoan,
    String? notes,
    bool clearError = false,
    bool clearReturnedLoan = false,
  }) {
    return LoanReturnState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      returnedLoan: clearReturnedLoan ? null : (returnedLoan ?? this.returnedLoan),
      notes: notes ?? this.notes,
    );
  }
}

/// Notifier para la devolución de préstamos
class LoanReturnNotifier extends StateNotifier<LoanReturnState> {
  final LoanRepository _loanRepository;

  LoanReturnNotifier(this._loanRepository) : super(const LoanReturnState());

  /// Actualiza las notas de devolución
  void updateNotes(String notes) {
    state = state.copyWith(notes: notes);
  }

  /// Devuelve un préstamo
  Future<void> returnLoan(String loanId) async {
    state = state.copyWith(isLoading: true, clearError: true);

    final result = await _loanRepository.returnAsset(
      loanId: loanId,
      returnDate: DateTime.now(),
      notes: state.notes?.isNotEmpty == true ? state.notes : null,
    );

    if (result.isSuccess) {
      state = state.copyWith(
        isLoading: false,
        returnedLoan: result.data,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.exception?.message ?? 'Error al devolver el préstamo',
      );
    }
  }

  /// Reinicia el estado
  void reset() {
    state = const LoanReturnState();
  }
}

/// Provider del notifier de devolución de préstamos
final loanReturnProvider = StateNotifierProvider<LoanReturnNotifier, LoanReturnState>((ref) {
  final repository = ref.watch(loanRepositoryProvider);
  return LoanReturnNotifier(repository);
});

/// Provider para verificar si un activo está prestado
final isAssetLoanedProvider = FutureProvider.family<bool, String>((ref, assetId) async {
  final activeLoan = await ref.watch(activeLoanByAssetProvider(assetId).future);
  return activeLoan != null;
});

/// Provider para obtener estadísticas de préstamos
final loanStatisticsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final repository = ref.watch(loanRepositoryProvider);
  final result = await repository.getLoanStatistics();
  
  if (result.isSuccess) {
    return result.data ?? {};
  } else {
    throw result.exception ?? Exception('Error al cargar estadísticas');
  }
});