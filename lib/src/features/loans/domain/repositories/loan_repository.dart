import '../entities/loan.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/exceptions/app_exceptions.dart';

/// Repositorio abstracto para gestión de préstamos
abstract class LoanRepository {
  /// Crea un nuevo préstamo
  Future<Result<Loan>> createLoan({
    required String assetId,
    required String borrowerId,
    required String lenderId,
    required DateTime startDate,
    required DateTime expectedReturnDate,
    String? notes,
  });
  
  /// Obtiene un préstamo por su ID
  Future<Result<Loan?>> getLoanById(String id);
  
  /// Obtiene todos los préstamos
  Future<Result<List<Loan>>> getAllLoans();
  
  /// Obtiene préstamos activos
  Future<Result<List<Loan>>> getActiveLoans();
  
  /// Obtiene préstamos cerrados
  Future<Result<List<Loan>>> getClosedLoans();
  
  /// Obtiene préstamos vencidos
  Future<Result<List<Loan>>> getOverdueLoans();
  
  /// Obtiene préstamos por activo
  Future<Result<List<Loan>>> getLoansByAsset(String assetId);
  
  /// Obtiene préstamos por prestatario
  Future<Result<List<Loan>>> getLoansByBorrower(String borrowerId);
  
  /// Obtiene préstamos por prestamista
  Future<Result<List<Loan>>> getLoansByLender(String lenderId);
  
  /// Obtiene el préstamo activo de un activo
  Future<Result<Loan?>> getActiveLoanByAsset(String assetId);
  
  /// Devuelve un activo prestado
  Future<Result<Loan>> returnAsset({
    required String loanId,
    required DateTime returnDate,
    String? notes,
  });
  
  /// Extiende la fecha de devolución de un préstamo
  Future<Result<Loan>> extendLoan({
    required String loanId,
    required DateTime newExpectedReturnDate,
    String? notes,
  });
  
  /// Actualiza las notas de un préstamo
  Future<Result<Loan>> updateLoanNotes({
    required String loanId,
    required String notes,
  });
  
  /// Cancela un préstamo (solo si no ha sido devuelto)
  Future<Result<void>> cancelLoan(String loanId);
  
  /// Obtiene el historial de préstamos de un activo
  Future<Result<List<Loan>>> getAssetLoanHistory(String assetId);
  
  /// Obtiene el historial de préstamos de un usuario
  Future<Result<List<Loan>>> getUserLoanHistory(String userId);
  
  /// Busca préstamos por criterios
  Future<Result<List<Loan>>> searchLoans({
    String? assetName,
    String? borrowerName,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  });
  
  /// Obtiene estadísticas de préstamos
  Future<Result<Map<String, dynamic>>> getLoanStatistics();
  
  /// Obtiene préstamos que vencen pronto
  Future<Result<List<Loan>>> getLoansExpiringSoon(int daysAhead);
  
  /// Sincroniza préstamos con el servidor
  Future<Result<void>> syncLoans();
  
  /// Obtiene el estado de sincronización
  Future<Result<bool>> getSyncStatus();
  
  /// Exporta préstamos a CSV
  Future<Result<String>> exportLoansToCSV({
    DateTime? startDate,
    DateTime? endDate,
    String? status,
  });
  
  /// Genera reporte de préstamos
  Future<Result<Map<String, dynamic>>> generateLoanReport({
    required DateTime startDate,
    required DateTime endDate,
    String? branchId,
  });
}