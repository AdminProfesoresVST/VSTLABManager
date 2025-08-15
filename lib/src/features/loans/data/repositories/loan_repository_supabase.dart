import '../../domain/entities/loan.dart';
import '../../domain/repositories/loan_repository.dart';
import '../models/loan_model.dart';
import '../../../../core/network/supabase_client.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/exceptions/app_exceptions.dart' as app_exceptions;
import '../../../../shared/constants/app_constants.dart';

/// Implementación Supabase del repositorio de préstamos
class LoanRepositorySupabase implements LoanRepository {
  
  @override
  Future<Result<Loan>> createLoan({
    required String assetId,
    required String borrowerId,
    required String lenderId,
    required DateTime startDate,
    required DateTime expectedReturnDate,
    String? notes,
  }) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final loan = LoanModel.create(
        assetId: assetId,
        borrowerId: borrowerId,
        lenderId: lenderId,
        startDate: startDate,
        expectedReturnDate: expectedReturnDate,
        notes: notes,
      );
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .insert(loan.toSupabaseMap())
          .select()
          .single();
      
      final createdLoan = LoanModel.fromSupabaseMap(response);
      return Result.success(createdLoan);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al crear préstamo: ${e.toString()}',
          code: 'CREATE_LOAN_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<Loan?>> getLoanById(String id) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .select('*')
          .eq('id', id)
          .maybeSingle();
      
      if (response == null) {
        return Result.success(null);
      }
      
      final loan = LoanModel.fromSupabaseMap(response);
      return Result.success(loan);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener préstamo: ${e.toString()}',
          code: 'GET_LOAN_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getAllLoans() async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .select('*')
          .order('start_date', ascending: false);
      
      final loans = (response as List)
          .map((map) => LoanModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener préstamos: ${e.toString()}',
          code: 'GET_ALL_LOANS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getActiveLoans() async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .select('*')
          .eq('status', 'active')
          .order('start_date', ascending: false);
      
      final loans = (response as List)
          .map((map) => LoanModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener préstamos activos: ${e.toString()}',
          code: 'GET_ACTIVE_LOANS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getClosedLoans() async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .select('*')
          .eq('status', 'returned')
          .order('start_date', ascending: false);
      
      final loans = (response as List)
          .map((map) => LoanModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener préstamos cerrados: ${e.toString()}',
          code: 'GET_CLOSED_LOANS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getOverdueLoans() async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final now = DateTime.now().toIso8601String();
      final response = await SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .select('*')
          .eq('status', 'active')
          .lt('expected_return_date', now)
          .order('expected_return_date', ascending: true);
      
      final loans = (response as List)
          .map((map) => LoanModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener préstamos vencidos: ${e.toString()}',
          code: 'GET_OVERDUE_LOANS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getLoansByAsset(String assetId) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .select('*')
          .eq('asset_id', assetId)
          .order('start_date', ascending: false);
      
      final loans = (response as List)
          .map((map) => LoanModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener préstamos por activo: ${e.toString()}',
          code: 'GET_LOANS_BY_ASSET_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getLoansByBorrower(String borrowerId) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .select('*')
          .eq('borrower_id', borrowerId)
          .order('start_date', ascending: false);
      
      final loans = (response as List)
          .map((map) => LoanModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener préstamos por usuario: ${e.toString()}',
          code: 'GET_LOANS_BY_BORROWER_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getLoansByLender(String lenderId) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .select('*')
          .eq('lender_id', lenderId)
          .order('start_date', ascending: false);
      
      final loans = (response as List)
          .map((map) => LoanModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener préstamos por prestamista: ${e.toString()}',
          code: 'GET_LOANS_BY_LENDER_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<Loan?>> getActiveLoanByAsset(String assetId) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .select('*')
          .eq('asset_id', assetId)
          .eq('status', 'active')
          .maybeSingle();
      
      if (response == null) {
        return Result.success(null);
      }
      
      final loan = LoanModel.fromSupabaseMap(response);
      return Result.success(loan);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener préstamo activo por activo: ${e.toString()}',
          code: 'GET_ACTIVE_LOAN_BY_ASSET_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<Loan>> returnAsset({
    required String loanId,
    required DateTime returnDate,
    String? notes,
  }) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final updateData = {
        'status': 'returned',
        'actual_return_date': returnDate.toIso8601String(),
        'notes': notes,
        'updated_at': DateTime.now().toIso8601String(),
      };
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .update(updateData)
          .eq('id', loanId)
          .select()
          .single();
      
      final returnedLoan = LoanModel.fromSupabaseMap(response);
      return Result.success(returnedLoan);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al devolver préstamo: ${e.toString()}',
          code: 'RETURN_LOAN_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<Loan>> extendLoan({
    required String loanId,
    required DateTime newExpectedReturnDate,
    String? notes,
  }) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final updateData = {
        'expected_return_date': newExpectedReturnDate.toIso8601String(),
        'notes': notes,
        'updated_at': DateTime.now().toIso8601String(),
      };
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .update(updateData)
          .eq('id', loanId)
          .select()
          .single();
      
      final extendedLoan = LoanModel.fromSupabaseMap(response);
      return Result.success(extendedLoan);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al extender préstamo: ${e.toString()}',
          code: 'EXTEND_LOAN_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<Loan>> updateLoanNotes({
    required String loanId,
    required String notes,
  }) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final updateData = {
        'notes': notes,
        'updated_at': DateTime.now().toIso8601String(),
      };
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .update(updateData)
          .eq('id', loanId)
          .select()
          .single();
      
      final updatedLoan = LoanModel.fromSupabaseMap(response);
      return Result.success(updatedLoan);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al actualizar notas del préstamo: ${e.toString()}',
          code: 'UPDATE_LOAN_NOTES_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<void>> cancelLoan(String loanId) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final updateData = {
        'status': 'cancelled',
        'updated_at': DateTime.now().toIso8601String(),
      };
      
      await SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .update(updateData)
          .eq('id', loanId);
      
      return Result.success(null);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al cancelar préstamo: ${e.toString()}',
          code: 'CANCEL_LOAN_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getAssetLoanHistory(String assetId) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .select('*')
          .eq('asset_id', assetId)
          .order('start_date', ascending: false);
      
      final loans = (response as List)
          .map((map) => LoanModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener historial de préstamos del activo: ${e.toString()}',
          code: 'GET_ASSET_LOAN_HISTORY_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getUserLoanHistory(String userId) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .select('*')
          .or('borrower_id.eq.$userId,lender_id.eq.$userId')
          .order('start_date', ascending: false);
      
      final loans = (response as List)
          .map((map) => LoanModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener historial de préstamos del usuario: ${e.toString()}',
          code: 'GET_USER_LOAN_HISTORY_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> searchLoans({
    String? assetName,
    String? borrowerName,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      var query = SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .select('*');
      
      if (status != null) {
        query = query.eq('status', status);
      }
      
      if (startDate != null) {
        query = query.gte('start_date', startDate.toIso8601String());
      }
      
      if (endDate != null) {
        query = query.lte('start_date', endDate.toIso8601String());
      }
      
      final response = await query.order('start_date', ascending: false);
      
      final loans = (response as List)
          .map((map) => LoanModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al buscar préstamos: ${e.toString()}',
          code: 'SEARCH_LOANS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<Map<String, dynamic>>> getLoanStatistics() async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      // Obtener todos los préstamos para calcular estadísticas
      final totalResponse = await SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .select('*')
          .neq('status', 'deleted');
      
      final allLoans = (totalResponse as List)
          .map((map) => LoanModel.fromSupabaseMap(map))
          .toList();
      
      final total = allLoans.length;
      final active = allLoans.where((l) => l.status == 'active').length;
      final returned = allLoans.where((l) => l.status == 'returned').length;
      final overdue = allLoans.where((l) => 
          l.status == 'active' && l.expectedReturnDate.isBefore(DateTime.now())
      ).length;
      
      final statistics = <String, dynamic>{
        'total': total,
        'active': active,
        'returned': returned,
        'overdue': overdue,
      };
      
      return Result.success(statistics);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener estadísticas: ${e.toString()}',
          code: 'GET_STATISTICS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getLoansExpiringSoon(int daysAhead) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final futureDate = DateTime.now().add(Duration(days: daysAhead)).toIso8601String();
      final response = await SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .select('*')
          .eq('status', 'active')
          .lte('expected_return_date', futureDate)
          .order('expected_return_date', ascending: true);
      
      final loans = (response as List)
          .map((map) => LoanModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener préstamos que vencen pronto: ${e.toString()}',
          code: 'GET_LOANS_EXPIRING_SOON_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<void>> syncLoans() async {
    try {
      // La sincronización se manejará en un servicio separado
      return Result.success(null);
    } catch (e) {
      return Result.failure(
        app_exceptions.SyncException(
          'Error al sincronizar préstamos: ${e.toString()}',
          code: 'SYNC_LOANS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<bool>> getSyncStatus() async {
    try {
      // En Supabase, siempre está sincronizado si hay conexión
      final isConnected = await SupabaseClientConfig.hasInternetConnection();
      return Result.success(isConnected);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener estado de sincronización: ${e.toString()}',
          code: 'GET_SYNC_STATUS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<String>> exportLoansToCSV({
    DateTime? startDate,
    DateTime? endDate,
    String? status,
  }) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      var query = SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .select('*');
      
      if (status != null) {
        query = query.eq('status', status);
      }
      
      if (startDate != null) {
        query = query.gte('start_date', startDate.toIso8601String());
      }
      
      if (endDate != null) {
        query = query.lte('start_date', endDate.toIso8601String());
      }
      
      final response = await query.order('start_date', ascending: false);
      
      final loans = (response as List)
          .map((map) => LoanModel.fromSupabaseMap(map))
          .toList();
      
      // Generar CSV
      final csvHeader = 'ID,Asset ID,Borrower ID,Lender ID,Start Date,Expected Return Date,Actual Return Date,Status,Notes,Created At,Updated At\n';
      final csvRows = loans.map((loan) => 
          '${loan.id},${loan.assetId},${loan.borrowerId},${loan.lenderId},${loan.startDate.toIso8601String()},${loan.expectedReturnDate.toIso8601String()},${loan.actualReturnDate?.toIso8601String() ?? ''},${loan.status},"${loan.notes ?? ''}",${loan.createdAt.toIso8601String()},${loan.updatedAt.toIso8601String()}'
      ).join('\n');
      
      final csvContent = csvHeader + csvRows;
      return Result.success(csvContent);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al exportar a CSV: ${e.toString()}',
          code: 'EXPORT_CSV_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<Map<String, dynamic>>> generateLoanReport({
    required DateTime startDate,
    required DateTime endDate,
    String? branchId,
  }) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      var query = SupabaseClientConfig.client
          .from(AppConstants.loansTable)
          .select('*')
          .gte('start_date', startDate.toIso8601String())
          .lte('start_date', endDate.toIso8601String());
      
      if (branchId != null) {
        // Para filtrar por sucursal, necesitaríamos hacer JOIN con la tabla de activos
        // Por simplicidad, omitimos este filtro por ahora
      }
      
      final response = await query.order('start_date', ascending: false);
      
      final loans = (response as List)
          .map((map) => LoanModel.fromSupabaseMap(map))
          .toList();
      
      final report = <String, dynamic>{
        'period': {
          'start': startDate.toIso8601String(),
          'end': endDate.toIso8601String(),
        },
        'total_loans': loans.length,
        'active_loans': loans.where((l) => l.status == 'active').length,
        'returned_loans': loans.where((l) => l.status == 'returned').length,
        'overdue_loans': loans.where((l) => l.status == 'active' && l.expectedReturnDate.isBefore(DateTime.now())).length,
        'loans': loans.map((l) => l.toJson()).toList(),
      };
      
      return Result.success(report);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al generar reporte de préstamos: ${e.toString()}',
          code: 'GENERATE_LOAN_REPORT_ERROR',
        ),
      );
    }
  }
}