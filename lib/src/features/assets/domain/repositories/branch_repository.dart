import '../entities/branch.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/exceptions/app_exceptions.dart';

/// Repositorio abstracto para gestión de sucursales
abstract class BranchRepository {
  /// Crea una nueva sucursal
  Future<Result<Branch>> createBranch({
    required String name,
    required String address,
    required String code,
  });
  
  /// Obtiene una sucursal por su ID
  Future<Result<Branch?>> getBranchById(String id);
  
  /// Obtiene una sucursal por su código
  Future<Result<Branch?>> getBranchByCode(String code);
  
  /// Obtiene todas las sucursales
  Future<Result<List<Branch>>> getAllBranches();
  
  /// Obtiene sucursales activas
  Future<Result<List<Branch>>> getActiveBranches();
  
  /// Busca sucursales por nombre o código
  Future<Result<List<Branch>>> searchBranches(String query);
  
  /// Actualiza una sucursal
  Future<Result<Branch>> updateBranch({
    required String id,
    String? name,
    String? address,
    String? code,
    bool? isActive,
  });
  
  /// Activa o desactiva una sucursal
  Future<Result<Branch>> toggleBranchStatus({
    required String id,
    required bool isActive,
  });
  
  /// Elimina una sucursal (soft delete)
  Future<Result<void>> deleteBranch(String id);
  
  /// Valida si un código de sucursal es único
  Future<Result<bool>> isBranchCodeUnique(String code);
  
  /// Obtiene estadísticas de una sucursal
  Future<Result<Map<String, dynamic>>> getBranchStatistics(String branchId);
  
  /// Sincroniza sucursales con el servidor
  Future<Result<void>> syncBranches();
  
  /// Obtiene el estado de sincronización
  Future<Result<bool>> getSyncStatus();
}