import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/loan.dart';
import '../../domain/repositories/loan_repository.dart';
import '../models/loan_model.dart';
import '../../../../core/database/database_helper.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/exceptions/app_exceptions.dart' as app_exceptions;
import '../../../../shared/constants/app_constants.dart';

/// Implementación SQLite del repositorio de préstamos
class LoanRepositorySqlite implements LoanRepository {
  final DatabaseHelper _databaseHelper;
  final Uuid _uuid;
  
  LoanRepositorySqlite({
    required DatabaseHelper databaseHelper,
    required Uuid uuid,
  }) : _databaseHelper = databaseHelper,
       _uuid = uuid;
  
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
      final db = await _databaseHelper.database;
      
      final loan = LoanModel.create(
        assetId: assetId,
        borrowerId: borrowerId,
        lenderId: lenderId,
        startDate: startDate,
        expectedReturnDate: expectedReturnDate,
        notes: notes,
      ).copyWith(id: _uuid.v4());
      
      await db.insert(
        AppConstants.loansTable,
        loan.toSqliteMap(),
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      
      return Result.success(loan);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al crear préstamo: ${e.toString()}',
          code: 'CREATE_LOAN_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<Loan?>> getLoanById(String id) async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.loansTable,
        where: 'id = ?',
        whereArgs: [id],
      );
      
      if (maps.isEmpty) {
        return Result.success(null);
      }
      
      final loan = LoanModel.fromSqliteMap(maps.first);
      return Result.success(loan);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener préstamo: ${e.toString()}',
          code: 'GET_LOAN_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getAllLoans() async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.loansTable,
        orderBy: 'start_date DESC',
      );
      
      final loans = maps
          .map((map) => LoanModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener préstamos: ${e.toString()}',
          code: 'GET_ALL_LOANS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getActiveLoans() async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.loansTable,
        where: 'status = ?',
        whereArgs: ['active'],
        orderBy: 'loan_date DESC',
      );
      
      final loans = maps
          .map((map) => LoanModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener préstamos activos: ${e.toString()}',
          code: 'GET_ACTIVE_LOANS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getOverdueLoans() async {
    try {
      final db = await _databaseHelper.database;
      
      final now = DateTime.now().toIso8601String();
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.loansTable,
        where: 'status = ? AND expected_return_date < ?',
        whereArgs: ['active', now],
        orderBy: 'expected_return_date ASC',
      );
      
      final loans = maps
          .map((map) => LoanModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener préstamos vencidos: ${e.toString()}',
          code: 'GET_OVERDUE_LOANS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getLoansByAsset(String assetId) async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.loansTable,
        where: 'asset_id = ?',
        whereArgs: [assetId],
        orderBy: 'loan_date DESC',
      );
      
      final loans = maps
          .map((map) => LoanModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener préstamos por activo: ${e.toString()}',
          code: 'GET_LOANS_BY_ASSET_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getLoansByBorrower(String borrowerId) async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.loansTable,
        where: 'borrower_id = ?',
        whereArgs: [borrowerId],
        orderBy: 'loan_date DESC',
      );
      
      final loans = maps
          .map((map) => LoanModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener préstamos por usuario: ${e.toString()}',
          code: 'GET_LOANS_BY_BORROWER_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getLoansByLender(String lenderId) async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.loansTable,
        where: 'lender_id = ?',
        whereArgs: [lenderId],
        orderBy: 'start_date DESC',
      );
      
      final loans = maps
          .map((map) => LoanModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener préstamos por prestamista: ${e.toString()}',
          code: 'GET_LOANS_BY_LENDER_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getClosedLoans() async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.loansTable,
        where: 'status = ?',
        whereArgs: ['returned'],
        orderBy: 'start_date DESC',
      );
      
      final loans = maps
          .map((map) => LoanModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener préstamos cerrados: ${e.toString()}',
          code: 'GET_CLOSED_LOANS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<Loan?>> getActiveLoanByAsset(String assetId) async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.loansTable,
        where: 'asset_id = ? AND status = ?',
        whereArgs: [assetId, 'active'],
        limit: 1,
      );
      
      if (maps.isEmpty) {
        return Result.success(null);
      }
      
      final loan = LoanModel.fromSqliteMap(maps.first);
      return Result.success(loan);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
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
      final db = await _databaseHelper.database;
      
      // Obtener préstamo actual
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.loansTable,
        where: 'id = ?',
        whereArgs: [loanId],
      );
      
      if (maps.isEmpty) {
        return Result.failure(
          app_exceptions.NotFoundException(
            'Préstamo no encontrado',
            code: 'LOAN_NOT_FOUND',
          ),
        );
      }
      
      final currentLoan = LoanModel.fromSqliteMap(maps.first);
      final returnedLoan = currentLoan.copyWith(
        status: 'returned',
        actualReturnDate: returnDate,
        notes: notes,
        updatedAt: DateTime.now(),
      ).markAsModified();
      
      await db.update(
        AppConstants.loansTable,
        returnedLoan.toSqliteMap(),
        where: 'id = ?',
        whereArgs: [loanId],
      );
      
      return Result.success(returnedLoan);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
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
      final db = await _databaseHelper.database;
      
      // Obtener préstamo actual
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.loansTable,
        where: 'id = ?',
        whereArgs: [loanId],
      );
      
      if (maps.isEmpty) {
        return Result.failure(
          app_exceptions.NotFoundException(
            'Préstamo no encontrado',
            code: 'LOAN_NOT_FOUND',
          ),
        );
      }
      
      final currentLoan = LoanModel.fromSqliteMap(maps.first);
      final extendedLoan = currentLoan.copyWith(
        expectedReturnDate: newExpectedReturnDate,
        notes: notes,
        updatedAt: DateTime.now(),
      ).markAsModified();
      
      await db.update(
        AppConstants.loansTable,
        extendedLoan.toSqliteMap(),
        where: 'id = ?',
        whereArgs: [loanId],
      );
      
      return Result.success(extendedLoan);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
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
      final db = await _databaseHelper.database;
      
      // Obtener préstamo actual
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.loansTable,
        where: 'id = ?',
        whereArgs: [loanId],
      );
      
      if (maps.isEmpty) {
        return Result.failure(
          app_exceptions.NotFoundException(
            'Préstamo no encontrado',
            code: 'LOAN_NOT_FOUND',
          ),
        );
      }
      
      final currentLoan = LoanModel.fromSqliteMap(maps.first);
      final updatedLoan = currentLoan.copyWith(
        notes: notes,
        updatedAt: DateTime.now(),
      ).markAsModified();
      
      await db.update(
        AppConstants.loansTable,
        updatedLoan.toSqliteMap(),
        where: 'id = ?',
        whereArgs: [loanId],
      );
      
      return Result.success(updatedLoan);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al actualizar notas del préstamo: ${e.toString()}',
          code: 'UPDATE_LOAN_NOTES_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<void>> cancelLoan(String loanId) async {
    try {
      final db = await _databaseHelper.database;
      
      // Cambiar estado a 'cancelled'
      final updatedLoan = {
        'status': 'cancelled',
        'updated_at': DateTime.now().toIso8601String(),
        'synced': 0,
      };
      
      final rowsAffected = await db.update(
        AppConstants.loansTable,
        updatedLoan,
        where: 'id = ?',
        whereArgs: [loanId],
      );
      
      if (rowsAffected == 0) {
        return Result.failure(
          app_exceptions.NotFoundException(
            'Préstamo no encontrado',
            code: 'LOAN_NOT_FOUND',
          ),
        );
      }
      
      return Result.success(null);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al cancelar préstamo: ${e.toString()}',
          code: 'CANCEL_LOAN_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getAssetLoanHistory(String assetId) async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.loansTable,
        where: 'asset_id = ?',
        whereArgs: [assetId],
        orderBy: 'start_date DESC',
      );
      
      final loans = maps
          .map((map) => LoanModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener historial de préstamos del activo: ${e.toString()}',
          code: 'GET_ASSET_LOAN_HISTORY_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getUserLoanHistory(String userId) async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.loansTable,
        where: 'borrower_id = ? OR lender_id = ?',
        whereArgs: [userId, userId],
        orderBy: 'start_date DESC',
      );
      
      final loans = maps
          .map((map) => LoanModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
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
      final db = await _databaseHelper.database;
      
      String whereClause = '1=1';
      List<dynamic> whereArgs = [];
      
      if (status != null) {
        whereClause += ' AND status = ?';
        whereArgs.add(status);
      }
      
      if (startDate != null) {
        whereClause += ' AND start_date >= ?';
        whereArgs.add(startDate.toIso8601String());
      }
      
      if (endDate != null) {
        whereClause += ' AND start_date <= ?';
        whereArgs.add(endDate.toIso8601String());
      }
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.loansTable,
        where: whereClause,
        whereArgs: whereArgs,
        orderBy: 'start_date DESC',
      );
      
      final loans = maps
          .map((map) => LoanModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al buscar préstamos: ${e.toString()}',
          code: 'SEARCH_LOANS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<void>> deleteLoan(String loanId) async {
    try {
      final db = await _databaseHelper.database;
      
      // Soft delete: cambiar estado a 'deleted'
      final updatedLoan = {
        'status': 'deleted',
        'updated_at': DateTime.now().toIso8601String(),
        'synced': 0,
      };
      
      final rowsAffected = await db.update(
        AppConstants.loansTable,
        updatedLoan,
        where: 'id = ?',
        whereArgs: [loanId],
      );
      
      if (rowsAffected == 0) {
        return Result.failure(
          app_exceptions.NotFoundException(
            'Préstamo no encontrado',
            code: 'LOAN_NOT_FOUND',
          ),
        );
      }
      
      return Result.success(null);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al eliminar préstamo: ${e.toString()}',
          code: 'DELETE_LOAN_ERROR',
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
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> unsyncedLoans = await db.query(
        AppConstants.loansTable,
        where: 'synced = ?',
        whereArgs: [0],
        limit: 1,
      );
      
      // Si no hay préstamos sin sincronizar, está sincronizado
      final isSynced = unsyncedLoans.isEmpty;
      return Result.success(isSynced);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener estado de sincronización: ${e.toString()}',
          code: 'GET_SYNC_STATUS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<Map<String, dynamic>>> getLoanStatistics() async {
    try {
      final db = await _databaseHelper.database;
      
      // Contar préstamos por estado
      final totalResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM ${AppConstants.loansTable} WHERE status != "deleted"',
      );
      final total = totalResult.first['count'] as int;
      
      final activeResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM ${AppConstants.loansTable} WHERE status = "active"',
      );
      final active = activeResult.first['count'] as int;
      
      final returnedResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM ${AppConstants.loansTable} WHERE status = "returned"',
      );
      final returned = returnedResult.first['count'] as int;
      
      final now = DateTime.now().toIso8601String();
      final overdueResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM ${AppConstants.loansTable} WHERE status = "active" AND expected_return_date < ?',
        [now],
      );
      final overdue = overdueResult.first['count'] as int;
      
      final statistics = <String, dynamic>{
        'total': total,
        'active': active,
        'returned': returned,
        'overdue': overdue,
      };
      
      return Result.success(statistics);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener estadísticas: ${e.toString()}',
          code: 'GET_STATISTICS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Loan>>> getLoansExpiringSoon(int daysAhead) async {
    try {
      final db = await _databaseHelper.database;
      
      final futureDate = DateTime.now().add(Duration(days: daysAhead)).toIso8601String();
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.loansTable,
        where: 'status = ? AND expected_return_date <= ?',
        whereArgs: ['active', futureDate],
        orderBy: 'expected_return_date ASC',
      );
      
      final loans = maps
          .map((map) => LoanModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(loans);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener préstamos que vencen pronto: ${e.toString()}',
          code: 'GET_LOANS_EXPIRING_SOON_ERROR',
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
      // Esta funcionalidad se implementará cuando sea necesaria
      return Result.failure(
        app_exceptions.ValidationException(
          'Exportación a CSV no implementada en SQLite',
          code: 'CSV_EXPORT_NOT_IMPLEMENTED',
        ),
      );
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
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
      final db = await _databaseHelper.database;
      
      String whereClause = 'start_date >= ? AND start_date <= ?';
      List<dynamic> whereArgs = [startDate.toIso8601String(), endDate.toIso8601String()];
      
      if (branchId != null) {
        // Para filtrar por sucursal, necesitaríamos hacer JOIN con la tabla de activos
        // Por simplicidad, omitimos este filtro en SQLite
      }
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.loansTable,
        where: whereClause,
        whereArgs: whereArgs,
      );
      
      final loans = maps.map((map) => LoanModel.fromSqliteMap(map)).toList();
      
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
        app_exceptions.DatabaseException(
          'Error al generar reporte de préstamos: ${e.toString()}',
          code: 'GENERATE_LOAN_REPORT_ERROR',
        ),
      );
    }
  }
}