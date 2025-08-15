import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/domain/entities/app_user.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

/// Widget para seleccionar el responsable del préstamo
class BorrowerSelectorWidget extends ConsumerStatefulWidget {
  final AppUser? selectedBorrower;
  final Function(AppUser) onBorrowerSelected;
  final String? errorText;

  const BorrowerSelectorWidget({
    super.key,
    this.selectedBorrower,
    required this.onBorrowerSelected,
    this.errorText,
  });

  @override
  ConsumerState<BorrowerSelectorWidget> createState() => _BorrowerSelectorWidgetState();
}

class _BorrowerSelectorWidgetState extends ConsumerState<BorrowerSelectorWidget> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isExpanded = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Responsable del préstamo',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        if (widget.selectedBorrower != null)
          _buildSelectedBorrower()
        else
          _buildBorrowerSelector(),
        if (widget.errorText != null) ...[
          const SizedBox(height: 8),
          Text(
            widget.errorText!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.red[600],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSelectedBorrower() {
    final borrower = widget.selectedBorrower!;
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
          CircleAvatar(
            radius: 20,
            backgroundColor: theme.primaryColor.withValues(alpha: 0.2),
            child: Text(
              borrower.fullName.isNotEmpty ? borrower.fullName[0].toUpperCase() : 'U',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  borrower.fullName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  borrower.email,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
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
                _isExpanded = false;
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

  Widget _buildBorrowerSelector() {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        // Campo de búsqueda
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Buscar usuario por nombre o email...',
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey[600],
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              icon: Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.grey[600],
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey[400]!,
              ),
            ),
            enabledBorder: OutlineInputBorder(
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
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
              _isExpanded = value.isNotEmpty;
            });
          },
          onTap: () {
            setState(() {
              _isExpanded = true;
            });
          },
        ),
        // Lista de usuarios
        if (_isExpanded) ...[
          const SizedBox(height: 8),
          _buildUsersList(),
        ],
      ],
    );
  }

  Widget _buildUsersList() {
    final theme = Theme.of(context);
    
    return Container(
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Consumer(
        builder: (context, ref, child) {
          final usersAsync = ref.watch(allUsersProvider);
          
          return usersAsync.when(
            data: (users) {
              final filteredUsers = _searchQuery.isEmpty
                  ? users
                  : users.where((user) {
                      return user.fullName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                             user.email.toLowerCase().contains(_searchQuery.toLowerCase());
                    }).toList();
              
              if (filteredUsers.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 48,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _searchQuery.isEmpty
                            ? 'No hay usuarios disponibles'
                            : 'No se encontraron usuarios',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              }
              
              return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: filteredUsers.length,
                separatorBuilder: (context, index) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return _buildUserItem(user);
                },
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red[600],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar usuarios',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.red[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserItem(AppUser user) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: () {
        widget.onBorrowerSelected(user);
        setState(() {
          _isExpanded = false;
          _searchController.clear();
          _searchQuery = '';
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
              child: Text(
                user.fullName.isNotEmpty ? user.fullName[0].toUpperCase() : 'U',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user.email,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
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
}