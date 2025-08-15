import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../data/repositories/asset_repository_sqlite.dart';
import '../../domain/entities/asset.dart';
import '../../domain/repositories/asset_repository.dart';
import '../../../../core/database/database_helper.dart';

/// Provider para el repositorio de activos
final assetRepositoryProvider = Provider<AssetRepository>((ref) {
  return AssetRepositorySqlite(
    databaseHelper: DatabaseHelper.instance,
    uuid: const Uuid(),
  );
});

/// Estado para la gestión de activos
class AssetState {
  /// Lista de activos
  final List<Asset> assets;
  
  /// Indica si hay una operación en progreso
  final bool isLoading;
  
  /// Mensaje de error si ocurrió algún problema
  final String? error;
  
  /// Activo seleccionado actualmente
  final Asset? selectedAsset;
  
  /// Indica si se está creando un nuevo activo
  final bool isCreating;
  
  /// Indica si se está actualizando un activo
  final bool isUpdating;

  /// Constructor del estado de activos
  const AssetState({
    this.assets = const [],
    this.isLoading = false,
    this.error,
    this.selectedAsset,
    this.isCreating = false,
    this.isUpdating = false,
  });

  /// Crea una copia del estado con los valores proporcionados
  AssetState copyWith({
    List<Asset>? assets,
    bool? isLoading,
    String? error,
    Asset? selectedAsset,
    bool? isCreating,
    bool? isUpdating,
    bool clearError = false,
    bool clearSelectedAsset = false,
  }) {
    return AssetState(
      assets: assets ?? this.assets,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      selectedAsset: clearSelectedAsset ? null : (selectedAsset ?? this.selectedAsset),
      isCreating: isCreating ?? this.isCreating,
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }
}

/// Notificador de estado de activos que maneja todas las operaciones CRUD
class AssetNotifier extends StateNotifier<AssetState> {
  final AssetRepository _assetRepository;

  /// Constructor que inicializa el notificador y carga los activos
  AssetNotifier(this._assetRepository) : super(const AssetState()) {
    loadAssets();
  }

  /// Cargar todos los activos
  Future<void> loadAssets() async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    final result = await _assetRepository.getAllAssets();
    
    if (result.isSuccess) {
      state = state.copyWith(
        isLoading: false,
        assets: result.data!,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.exception?.message ?? 'Error al cargar activos',
      );
    }
  }

  /// Crear un nuevo activo
  Future<bool> createAsset({
    required String name,
    required String description,
    required double value,
    required String branchId,
    String? imageUrl,
  }) async {
    state = state.copyWith(isCreating: true, clearError: true);
    
    final result = await _assetRepository.createAsset(
      name: name,
      description: description,
      value: value,
      branchId: branchId,
      imageUrl: imageUrl,
    );
    
    if (result.isSuccess) {
      state = state.copyWith(
        isCreating: false,
        assets: [...state.assets, result.data!],
      );
      return true;
    } else {
      state = state.copyWith(
        isCreating: false,
        error: result.exception?.message ?? 'Error al crear activo',
      );
      return false;
    }
  }

  /// Obtener un activo por ID
  Future<void> getAssetById(String assetId) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    final result = await _assetRepository.getAssetById(assetId);
    
    if (result.isSuccess) {
      state = state.copyWith(
        isLoading: false,
        selectedAsset: result.data,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.exception?.message ?? 'Error al obtener activo',
      );
    }
  }

  /// Actualizar un activo existente
  Future<bool> updateAsset({
    required String id,
    String? name,
    String? description,
    double? value,
    String? status,
    String? imageUrl,
  }) async {
    state = state.copyWith(isUpdating: true, clearError: true);
    
    final result = await _assetRepository.updateAsset(
      id: id,
      name: name,
      description: description,
      value: value,
      status: status,
      imageUrl: imageUrl,
    );
    
    if (result.isSuccess) {
      final updatedAssets = state.assets.map((a) {
        return a.id == id ? result.data! : a;
      }).toList();
      
      state = state.copyWith(
        isUpdating: false,
        assets: updatedAssets,
        selectedAsset: result.data,
      );
      return true;
    } else {
      state = state.copyWith(
        isUpdating: false,
        error: result.exception?.message ?? 'Error al actualizar activo',
      );
      return false;
    }
  }

  /// Eliminar un activo
  Future<bool> deleteAsset(String assetId) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    final result = await _assetRepository.deleteAsset(assetId);
    
    if (result.isSuccess) {
      final updatedAssets = state.assets.where((a) => a.id != assetId).toList();
      
      state = state.copyWith(
        isLoading: false,
        assets: updatedAssets,
        clearSelectedAsset: true,
      );
      return true;
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.exception?.message ?? 'Error al eliminar activo',
      );
      return false;
    }
  }

  /// Buscar activos por término
  Future<void> searchAssets(String searchTerm) async {
    if (searchTerm.trim().isEmpty) {
      await loadAssets();
      return;
    }
    
    state = state.copyWith(isLoading: true, clearError: true);
    
    final result = await _assetRepository.searchAssets(searchTerm);
    
    if (result.isSuccess) {
      state = state.copyWith(
        isLoading: false,
        assets: result.data!,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.exception?.message ?? 'Error al buscar activos',
      );
    }
  }

  /// Obtener activos por sucursal
  Future<void> getAssetsByBranch(String branchId) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    final result = await _assetRepository.getAssetsByBranch(branchId);
    
    if (result.isSuccess) {
      state = state.copyWith(
        isLoading: false,
        assets: result.data!,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.exception?.message ?? 'Error al obtener activos por sucursal',
      );
    }
  }

  /// Obtener activos por estado
  Future<void> getAssetsByStatus(String status) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    final result = await _assetRepository.getAssetsByStatus(status);
    
    if (result.isSuccess) {
      state = state.copyWith(
        isLoading: false,
        assets: result.data!,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.exception?.message ?? 'Error al obtener activos por estado',
      );
    }
  }

  /// Limpiar el error actual
  void clearError() {
    state = state.copyWith(clearError: true);
  }

  /// Limpiar el activo seleccionado
  void clearSelectedAsset() {
    state = state.copyWith(clearSelectedAsset: true);
  }
}

/// Provider del notificador de activos
final assetNotifierProvider = StateNotifierProvider<AssetNotifier, AssetState>((ref) {
  final repository = ref.watch(assetRepositoryProvider);
  return AssetNotifier(repository);
});

/// Provider para verificar si hay activos cargados
final hasAssetsProvider = Provider<bool>((ref) {
  final assetState = ref.watch(assetNotifierProvider);
  return assetState.assets.isNotEmpty;
});

/// Provider para obtener el número total de activos
final assetCountProvider = Provider<int>((ref) {
  final assetState = ref.watch(assetNotifierProvider);
  return assetState.assets.length;
});

/// Provider para obtener activos disponibles (no prestados)
final availableAssetsProvider = Provider<List<Asset>>((ref) {
  final assetState = ref.watch(assetNotifierProvider);
  return assetState.assets.where((asset) => asset.status == 'available').toList();
});

/// Provider para obtener activos prestados
final loanedAssetsProvider = Provider<List<Asset>>((ref) {
  final assetState = ref.watch(assetNotifierProvider);
  return assetState.assets.where((asset) => asset.status == 'loaned').toList();
});

/// Provider para obtener activos en mantenimiento
final maintenanceAssetsProvider = Provider<List<Asset>>((ref) {
  final assetState = ref.watch(assetNotifierProvider);
  return assetState.assets.where((asset) => asset.status == 'maintenance').toList();
});