import '../entities/asset.dart';
import '../entities/branch.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/exceptions/app_exceptions.dart';

/// Repositorio abstracto para gestión de activos
abstract class AssetRepository {
  /// Crea un nuevo activo
  Future<Result<Asset>> createAsset({
    required String name,
    required String description,
    required double value,
    required String branchId,
    String? imageUrl,
  });
  
  /// Obtiene un activo por su ID
  Future<Result<Asset?>> getAssetById(String id);
  
  /// Obtiene un activo por su código QR
  Future<Result<Asset?>> getAssetByQrCode(String qrCode);
  
  /// Obtiene todos los activos
  Future<Result<List<Asset>>> getAllAssets();
  
  /// Obtiene activos por sucursal
  Future<Result<List<Asset>>> getAssetsByBranch(String branchId);
  
  /// Obtiene activos por estado
  Future<Result<List<Asset>>> getAssetsByStatus(String status);
  
  /// Busca activos por nombre o descripción
  Future<Result<List<Asset>>> searchAssets(String query);
  
  /// Actualiza un activo
  Future<Result<Asset>> updateAsset({
    required String id,
    String? name,
    String? description,
    double? value,
    String? status,
    String? imageUrl,
  });
  
  /// Cambia el estado de un activo
  Future<Result<Asset>> changeAssetStatus({
    required String id,
    required String status,
  });
  
  /// Elimina un activo (soft delete)
  Future<Result<void>> deleteAsset(String id);
  
  /// Obtiene activos disponibles para préstamo
  Future<Result<List<Asset>>> getAvailableAssets();
  
  /// Obtiene activos prestados
  Future<Result<List<Asset>>> getLoanedAssets();
  
  /// Obtiene activos en mantenimiento
  Future<Result<List<Asset>>> getAssetsInMaintenance();
  
  /// Genera un código QR único para un activo
  Future<Result<String>> generateQrCode(String assetId);
  
  /// Valida si un código QR es único
  Future<Result<bool>> isQrCodeUnique(String qrCode);
  
  /// Sincroniza activos con el servidor
  Future<Result<void>> syncAssets();
  
  /// Obtiene el estado de sincronización
  Future<Result<bool>> getSyncStatus();
  
  /// Obtiene estadísticas de activos
  Future<Result<Map<String, int>>> getAssetStatistics();
  
  /// Exporta activos a CSV
  Future<Result<String>> exportAssetsToCSV();
  
  /// Importa activos desde CSV
  Future<Result<List<Asset>>> importAssetsFromCSV(String csvData);
}