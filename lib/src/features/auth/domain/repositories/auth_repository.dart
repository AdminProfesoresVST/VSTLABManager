import '../entities/app_user.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/exceptions/app_exceptions.dart';

/// Repositorio abstracto para autenticación
abstract class AuthRepository {
  /// Inicia sesión con email y contraseña
  Future<Result<AppUser>> signIn({
    required String email,
    required String password,
  });
  
  /// Cierra la sesión del usuario actual
  Future<Result<void>> signOut();
  
  /// Obtiene el usuario autenticado actual
  Future<Result<AppUser?>> getCurrentUser();
  
  /// Verifica si hay un usuario autenticado
  Future<Result<bool>> isAuthenticated();
  
  /// Registra un nuevo usuario (solo para administradores)
  Future<Result<AppUser>> signUp({
    required String email,
    required String password,
    required String fullName,
    required String role,
    required String branchId,
  });
  
  /// Actualiza el perfil del usuario actual
  Future<Result<AppUser>> updateProfile({
    required String userId,
    String? fullName,
    String? role,
    String? branchId,
    bool? isActive,
  });
  
  /// Cambia la contraseña del usuario actual
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });
  
  /// Restablece la contraseña por email
  Future<Result<void>> resetPassword({
    required String email,
  });
  
  /// Obtiene todos los usuarios (solo para administradores)
  Future<Result<List<AppUser>>> getAllUsers();
  
  /// Obtiene usuarios por sucursal
  Future<Result<List<AppUser>>> getUsersByBranch(String branchId);
  
  /// Obtiene usuarios por rol
  Future<Result<List<AppUser>>> getUsersByRole(String role);
  
  /// Busca usuarios por nombre o email
  Future<Result<List<AppUser>>> searchUsers(String query);
  
  /// Activa o desactiva un usuario
  Future<Result<AppUser>> toggleUserStatus({
    required String userId,
    required bool isActive,
  });
  
  /// Elimina un usuario (soft delete)
  Future<Result<void>> deleteUser(String userId);
  
  /// Sincroniza datos de usuarios con el servidor
  Future<Result<void>> syncUsers();
  
  /// Obtiene el estado de sincronización
  Future<Result<bool>> getSyncStatus();
}