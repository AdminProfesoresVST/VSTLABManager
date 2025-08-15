import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../assets/domain/entities/asset.dart';
import '../../../assets/presentation/providers/asset_providers.dart';

/// Widget para seleccionar un activo disponible para préstamo
class AssetSelectorWidget extends ConsumerStatefulWidget {
  final Asset? selectedAsset;
  final Function(Asset) onAssetSelected;

  const AssetSelectorWidget({
    super.key,
    this.selectedAsset,
    required this.onAssetSelected,
  });

  @override
  ConsumerState<AssetSelectorWidget> createState() => _AssetSelectorWidgetState();
}

class _AssetSelectorWidgetState extends ConsumerState<AssetSelectorWidget> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final availableAssets = ref.watch(availableAssetsProvider);
    
    // Filtrar activos basado en la búsqueda
    final filteredAssets = availableAssets.where((asset) {
      if (_searchQuery.isEmpty) return true;
      return asset.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          asset.qrCode.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.selectedAsset != null) ...[
            _buildSelectedAsset(),
          ],
          if (widget.selectedAsset == null) ...[
            _buildSearchField(),
            const SizedBox(height: 16),
            _buildAssetsList(filteredAssets),
          ],
        ],
      ),
    );
  }

  Widget _buildSelectedAsset() {
    final asset = widget.selectedAsset!;
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.primaryColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: theme.primaryColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              color: theme.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  asset.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'QR: ${asset.qrCode}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                if (asset.description?.isNotEmpty == true)
                  Text(
                    asset.description!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // Limpiar selección
              setState(() {
                _searchQuery = '';
                _searchController.clear();
              });
            },
            icon: Icon(
              Icons.close,
              color: Colors.red[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    final theme = Theme.of(context);
    
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Buscar activo por nombre o código QR...',
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: Colors.grey[600],
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey[600],
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey[400]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: theme.primaryColor,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      style: theme.textTheme.bodyMedium?.copyWith(
        color: Colors.black87,
      ),
      onChanged: (value) {
        setState(() {
          _searchQuery = value;
        });
      },
    );
  }

  Widget _buildAssetsList(List<Asset> assets) {
    if (assets.isEmpty) {
      return _buildEmptyState();
    }

    return Container(
      constraints: const BoxConstraints(maxHeight: 300),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: assets.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final asset = assets[index];
          return _buildAssetItem(asset);
        },
      ),
    );
  }

  Widget _buildAssetItem(Asset asset) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: () => widget.onAssetSelected(asset),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: theme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                color: theme.primaryColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    asset.name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'QR: ${asset.qrCode}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  if (asset.description?.isNotEmpty == true)
                     Text(
                      asset.description!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isEmpty
                ? 'No hay activos disponibles'
                : 'No se encontraron activos',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isEmpty
                ? 'Todos los activos están prestados o en mantenimiento'
                : 'Intenta con otros términos de búsqueda',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}