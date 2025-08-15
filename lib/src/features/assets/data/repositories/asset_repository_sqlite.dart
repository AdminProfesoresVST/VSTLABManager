import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/asset.dart';
import '../../domain/repositories/asset_repository.dart';
import '../models/asset_model.dart';
import '../../../../core/database/database_helper.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/exceptions/app_exceptions.dart' as app_exceptions;
import '../../../../shared/constants/app_constants.dart';

/// Implementación SQLite del repositorio de activos
class AssetRepositorySqlite implements AssetRepository {
  final DatabaseHelper _databaseHelper;
  final Uuid _uuid;
  
  AssetRepositorySqlite({
    required DatabaseHelper databaseHelper,
    required Uuid uuid,
  }) : _databaseHelper = databaseHelper,
       _uuid = uuid;
  
  @override
  Future<Result<Asset>> createAsset({
    required String name,
    required String description,
    required double value,
    required String branchId,
    String? imageUrl,
  }) async {
    try {
      final db = await _databaseHelper.database;
      
      final asset = AssetModel.create(
        name: name,
        description: description,
        value: value,
        branchId: branchId,
        qrCode: '', // Se generará después
        imageUrl: imageUrl,
      ).copyWith(id: _uuid.v4());
      
      await db.insert(
        AppConstants.assetsTable,
        asset.toSqliteMap(),
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      
      return Result.success(asset);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al crear activo: ${e.toString()}',
          code: 'CREATE_ASSET_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<Asset?>> getAssetById(String assetId) async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.assetsTable,
        where: 'id = ?',
        whereArgs: [assetId],
      );
      
      if (maps.isEmpty) {
        return Result.success(null);
      }
      
      final asset = AssetModel.fromSqliteMap(maps.first);
      return Result.success(asset);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener activo: ${e.toString()}',
          code: 'GET_ASSET_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<Asset?>> getAssetByQrCode(String qrCode) async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.assetsTable,
        where: 'qr_code = ?',
        whereArgs: [qrCode],
      );
      
      if (maps.isEmpty) {
        return Result.success(null);
      }
      
      final asset = AssetModel.fromSqliteMap(maps.first);
      return Result.success(asset);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener activo por QR: ${e.toString()}',
          code: 'GET_ASSET_BY_QR_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Asset>>> getAllAssets() async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.assetsTable,
        orderBy: 'name ASC',
      );
      
      final assets = maps
          .map((map) => AssetModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(assets);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener activos: ${e.toString()}',
          code: 'GET_ALL_ASSETS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Asset>>> getAssetsByBranch(String branchId) async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.assetsTable,
        where: 'branch_id = ?',
        whereArgs: [branchId],
        orderBy: 'name ASC',
      );
      
      final assets = maps
          .map((map) => AssetModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(assets);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener activos por sucursal: ${e.toString()}',
          code: 'GET_ASSETS_BY_BRANCH_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Asset>>> getAssetsByStatus(String status) async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.assetsTable,
        where: 'status = ?',
        whereArgs: [status],
        orderBy: 'name ASC',
      );
      
      final assets = maps
          .map((map) => AssetModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(assets);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener activos por estado: ${e.toString()}',
          code: 'GET_ASSETS_BY_STATUS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Asset>>> searchAssets(String query) async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.assetsTable,
        where: 'name LIKE ? OR description LIKE ? OR serial_number LIKE ? OR model LIKE ? OR brand LIKE ?',
        whereArgs: ['%$query%', '%$query%', '%$query%', '%$query%', '%$query%'],
        orderBy: 'name ASC',
      );
      
      final assets = maps
          .map((map) => AssetModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(assets);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al buscar activos: ${e.toString()}',
          code: 'SEARCH_ASSETS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<Asset>> updateAsset({
    required String id,
    String? name,
    String? description,
    double? value,
    String? status,
    String? imageUrl,
  }) async {
    try {
      final db = await _databaseHelper.database;
      
      // Obtener activo actual
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.assetsTable,
        where: 'id = ?',
        whereArgs: [id],
      );
      
      if (maps.isEmpty) {
        return Result.failure(
          app_exceptions.NotFoundException(
            'Activo no encontrado',
            code: 'ASSET_NOT_FOUND',
          ),
        );
      }
      
      final currentAsset = AssetModel.fromSqliteMap(maps.first);
      final updatedAsset = currentAsset.copyWith(
        name: name,
        description: description,
        value: value,
        status: status,
        imageUrl: imageUrl,
        updatedAt: DateTime.now(),
      ).markAsModified();
      
      await db.update(
        AppConstants.assetsTable,
        updatedAsset.toSqliteMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
      
      return Result.success(updatedAsset);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al actualizar activo: ${e.toString()}',
          code: 'UPDATE_ASSET_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<Asset>> changeAssetStatus({
    required String id,
    required String status,
  }) async {
    try {
      final db = await _databaseHelper.database;
      
      // Obtener activo actual
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.assetsTable,
        where: 'id = ?',
        whereArgs: [id],
      );
      
      if (maps.isEmpty) {
        return Result.failure(
          app_exceptions.NotFoundException(
            'Activo no encontrado',
            code: 'ASSET_NOT_FOUND',
          ),
        );
      }
      
      final currentAsset = AssetModel.fromSqliteMap(maps.first);
      final updatedAsset = currentAsset.copyWith(
        status: status,
        updatedAt: DateTime.now(),
      ).markAsModified();
      
      await db.update(
        AppConstants.assetsTable,
        updatedAsset.toSqliteMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
      
      return Result.success(updatedAsset);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al cambiar estado del activo: ${e.toString()}',
          code: 'CHANGE_ASSET_STATUS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<void>> deleteAsset(String assetId) async {
    try {
      final db = await _databaseHelper.database;
      
      // Soft delete: cambiar estado a 'deleted'
      final updatedAsset = {
        'status': 'deleted',
        'updated_at': DateTime.now().toIso8601String(),
        'synced': 0,
      };
      
      final rowsAffected = await db.update(
        AppConstants.assetsTable,
        updatedAsset,
        where: 'id = ?',
        whereArgs: [assetId],
      );
      
      if (rowsAffected == 0) {
        return Result.failure(
          app_exceptions.NotFoundException(
            'Activo no encontrado',
            code: 'ASSET_NOT_FOUND',
          ),
        );
      }
      
      return Result.success(null);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al eliminar activo: ${e.toString()}',
          code: 'DELETE_ASSET_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<String>> generateQrCode(String assetId) async {
    try {
      final db = await _databaseHelper.database;
      
      // Verificar que el activo existe
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.assetsTable,
        where: 'id = ?',
        whereArgs: [assetId],
      );
      
      if (maps.isEmpty) {
        return Result.failure(
          app_exceptions.NotFoundException(
            'Activo no encontrado',
            code: 'ASSET_NOT_FOUND',
          ),
        );
      }
      
      // Generar código QR único
      final qrCode = 'VSTLAB_${assetId.substring(0, 8).toUpperCase()}';
      
      // Actualizar el activo con el código QR
      await db.update(
        AppConstants.assetsTable,
        {
          'qr_code': qrCode,
          'updated_at': DateTime.now().toIso8601String(),
          'synced': 0,
        },
        where: 'id = ?',
        whereArgs: [assetId],
      );
      
      return Result.success(qrCode);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al generar código QR: ${e.toString()}',
          code: 'GENERATE_QR_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<bool>> isQrCodeUnique(String qrCode) async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.assetsTable,
        where: 'qr_code = ?',
        whereArgs: [qrCode],
        limit: 1,
      );
      
      // Es único si no se encuentra ningún resultado
      return Result.success(maps.isEmpty);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al validar código QR: ${e.toString()}',
          code: 'VALIDATE_QR_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<void>> syncAssets() async {
    try {
      // La sincronización se manejará en un servicio separado
      return Result.success(null);
    } catch (e) {
      return Result.failure(
        app_exceptions.SyncException(
          'Error al sincronizar activos: ${e.toString()}',
          code: 'SYNC_ASSETS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<bool>> getSyncStatus() async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> unsyncedAssets = await db.query(
        AppConstants.assetsTable,
        where: 'synced = ?',
        whereArgs: [0],
        limit: 1,
      );
      
      // Si no hay activos sin sincronizar, está sincronizado
      final isSynced = unsyncedAssets.isEmpty;
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
  Future<Result<Map<String, int>>> getAssetStatistics() async {
    try {
      final db = await _databaseHelper.database;
      
      // Contar activos por estado
      final totalResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM ${AppConstants.assetsTable} WHERE status != "deleted"',
      );
      final total = totalResult.first['count'] as int;
      
      final availableResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM ${AppConstants.assetsTable} WHERE status = "available"',
      );
      final available = availableResult.first['count'] as int;
      
      final loanedResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM ${AppConstants.assetsTable} WHERE status = "loaned"',
      );
      final loaned = loanedResult.first['count'] as int;
      
      final maintenanceResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM ${AppConstants.assetsTable} WHERE status = "maintenance"',
      );
      final maintenance = maintenanceResult.first['count'] as int;
      
      final statistics = {
        'total': total,
        'available': available,
        'loaned': loaned,
        'maintenance': maintenance,
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
  Future<Result<List<Asset>>> getAvailableAssets() async {
    return getAssetsByStatus('available');
  }
  
  @override
  Future<Result<List<Asset>>> getLoanedAssets() async {
    return getAssetsByStatus('loaned');
  }
  
  @override
  Future<Result<List<Asset>>> getAssetsInMaintenance() async {
    return getAssetsByStatus('maintenance');
  }
  
  @override
  Future<Result<String>> exportAssetsToCSV() async {
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
  Future<Result<List<Asset>>> importAssetsFromCSV(String csvData) async {
    try {
      // Esta funcionalidad se implementará cuando sea necesaria
      return Result.failure(
        app_exceptions.ValidationException(
          'Importación desde CSV no implementada en SQLite',
          code: 'CSV_IMPORT_NOT_IMPLEMENTED',
        ),
      );
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al importar desde CSV: ${e.toString()}',
          code: 'IMPORT_CSV_ERROR',
        ),
      );
    }
  }
}