import 'package:uuid/uuid.dart';
import '../../domain/entities/asset.dart';
import '../../domain/repositories/asset_repository.dart';
import '../models/asset_model.dart';
import '../../../../core/network/supabase_client.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/exceptions/app_exceptions.dart' as app_exceptions;
import '../../../../shared/constants/app_constants.dart';

/// Implementación Supabase del repositorio de activos
class AssetRepositorySupabase implements AssetRepository {
  final Uuid _uuid;
  
  AssetRepositorySupabase({
    required Uuid uuid,
  }) : _uuid = uuid;
  
  @override
  Future<Result<Asset>> createAsset({
    required String name,
    required String description,
    required double value,
    required String branchId,
    String? imageUrl,
  }) async {
    try {
      // Verificar conexión a internet
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'No hay conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final asset = AssetModel.create(
        name: name,
        description: description,
        value: value,
        branchId: branchId,
        qrCode: '', // Se generará después
        imageUrl: imageUrl,
      ).copyWith(id: _uuid.v4());
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.assetsTable)
          .insert(asset.toSupabaseMap())
          .select()
          .single();
      
      final createdAsset = AssetModel.fromSupabaseMap(response);
      return Result.success(createdAsset);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al crear activo: ${e.toString()}',
          code: 'CREATE_ASSET_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<Asset?>> getAssetById(String id) async {
    try {
      // Verificar conexión a internet
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'No hay conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.assetsTable)
          .select()
          .eq('id', id)
          .maybeSingle();
      
      if (response == null) {
        return Result.success(null);
      }
      
      final asset = AssetModel.fromSupabaseMap(response);
      return Result.success(asset);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener activo: ${e.toString()}',
          code: 'GET_ASSET_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<Asset?>> getAssetByQrCode(String qrCode) async {
    try {
      // Verificar conexión a internet
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'No hay conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.assetsTable)
          .select()
          .eq('qr_code', qrCode)
          .maybeSingle();
      
      if (response == null) {
        return Result.success(null);
      }
      
      final asset = AssetModel.fromSupabaseMap(response);
      return Result.success(asset);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener activo por QR: ${e.toString()}',
          code: 'GET_ASSET_BY_QR_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Asset>>> getAllAssets() async {
    try {
      // Verificar conexión a internet
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'No hay conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.assetsTable)
          .select()
          .neq('status', 'deleted')
          .order('name');
      
      final assets = response
          .map((map) => AssetModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(assets);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener activos: ${e.toString()}',
          code: 'GET_ALL_ASSETS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Asset>>> getAssetsByBranch(String branchId) async {
    try {
      // Verificar conexión a internet
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'No hay conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.assetsTable)
          .select()
          .eq('branch_id', branchId)
          .neq('status', 'deleted')
          .order('name');
      
      final assets = response
          .map((map) => AssetModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(assets);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener activos por sucursal: ${e.toString()}',
          code: 'GET_ASSETS_BY_BRANCH_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Asset>>> getAssetsByStatus(String status) async {
    try {
      // Verificar conexión a internet
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'No hay conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.assetsTable)
          .select()
          .eq('status', status)
          .order('name');
      
      final assets = response
          .map((map) => AssetModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(assets);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener activos por estado: ${e.toString()}',
          code: 'GET_ASSETS_BY_STATUS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<Asset>>> searchAssets(String query) async {
    try {
      // Verificar conexión a internet
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'No hay conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.assetsTable)
          .select()
          .or('name.ilike.%$query%,description.ilike.%$query%')
          .neq('status', 'deleted')
          .order('name');
      
      final assets = response
          .map((map) => AssetModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(assets);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
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
      // Verificar conexión a internet
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'No hay conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final updateData = <String, dynamic>{
        'updated_at': DateTime.now().toIso8601String(),
      };
      
      if (name != null) updateData['name'] = name;
      if (description != null) updateData['description'] = description;
      if (value != null) updateData['value'] = value;
      if (status != null) updateData['status'] = status;
      if (imageUrl != null) updateData['image_url'] = imageUrl;
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.assetsTable)
          .update(updateData)
          .eq('id', id)
          .select()
          .single();
      
      final updatedAsset = AssetModel.fromSupabaseMap(response);
      return Result.success(updatedAsset);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
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
      // Verificar conexión a internet
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'No hay conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.assetsTable)
          .update({
            'status': status,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', id)
          .select()
          .single();
      
      final updatedAsset = AssetModel.fromSupabaseMap(response);
      return Result.success(updatedAsset);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al cambiar estado del activo: ${e.toString()}',
          code: 'CHANGE_ASSET_STATUS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<void>> deleteAsset(String id) async {
    try {
      // Verificar conexión a internet
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'No hay conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      // Soft delete: cambiar estado a 'deleted'
      await SupabaseClientConfig.client
          .from(AppConstants.assetsTable)
          .update({
            'status': 'deleted',
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', id);
      
      return Result.success(null);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al eliminar activo: ${e.toString()}',
          code: 'DELETE_ASSET_ERROR',
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
  Future<Result<String>> generateQrCode(String assetId) async {
    try {
      // Verificar conexión a internet
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'No hay conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      // Generar código QR único
      final qrCode = 'VSTLAB_${assetId.substring(0, 8).toUpperCase()}';
      
      // Actualizar el activo con el código QR
      await SupabaseClientConfig.client
          .from(AppConstants.assetsTable)
          .update({
            'qr_code': qrCode,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', assetId);
      
      return Result.success(qrCode);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al generar código QR: ${e.toString()}',
          code: 'GENERATE_QR_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<bool>> isQrCodeUnique(String qrCode) async {
    try {
      // Verificar conexión a internet
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'No hay conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await SupabaseClientConfig.client
          .from(AppConstants.assetsTable)
          .select('id')
          .eq('qr_code', qrCode)
          .maybeSingle();
      
      // Es único si no se encuentra ningún resultado
      return Result.success(response == null);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
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
  Future<Result<Map<String, int>>> getAssetStatistics() async {
    try {
      // Verificar conexión a internet
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'No hay conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      // Obtener estadísticas usando consultas de conteo
      final totalResponse = await SupabaseClientConfig.client
          .from(AppConstants.assetsTable)
          .select('*')
          .neq('status', 'deleted');
      
      final availableResponse = await SupabaseClientConfig.client
          .from(AppConstants.assetsTable)
          .select('*')
          .eq('status', 'available');
      
      final loanedResponse = await SupabaseClientConfig.client
          .from(AppConstants.assetsTable)
          .select('*')
          .eq('status', 'loaned');
      
      final maintenanceResponse = await SupabaseClientConfig.client
          .from(AppConstants.assetsTable)
          .select('*')
          .eq('status', 'maintenance');
      
      final statistics = {
        'total': totalResponse.length,
        'available': availableResponse.length,
        'loaned': loanedResponse.length,
        'maintenance': maintenanceResponse.length,
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
  Future<Result<String>> exportAssetsToCSV() async {
    try {
      // Verificar conexión a internet
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'No hay conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      // Esta funcionalidad se implementará cuando sea necesaria
      return Result.failure(
        app_exceptions.ValidationException(
          'Exportación a CSV no implementada en Supabase',
          code: 'CSV_EXPORT_NOT_IMPLEMENTED',
        ),
      );
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
  Future<Result<List<Asset>>> importAssetsFromCSV(String csvData) async {
    try {
      // Verificar conexión a internet
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'No hay conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      // Esta funcionalidad se implementará cuando sea necesaria
      return Result.failure(
        app_exceptions.ValidationException(
          'Importación desde CSV no implementada en Supabase',
          code: 'CSV_IMPORT_NOT_IMPLEMENTED',
        ),
      );
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al importar desde CSV: ${e.toString()}',
          code: 'IMPORT_CSV_ERROR',
        ),
      );
    }
  }
}