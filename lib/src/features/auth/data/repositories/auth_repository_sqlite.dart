import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/app_user_model.dart';
import '../../../../core/database/database_helper.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/exceptions/app_exceptions.dart' as app_exceptions;
import '../../../../shared/constants/app_constants.dart';

/// Implementación SQLite del repositorio de autenticación
class AuthRepositorySqlite implements AuthRepository {
  final DatabaseHelper _databaseHelper;
  final Uuid _uuid;
  
  AuthRepositorySqlite({
    required DatabaseHelper databaseHelper,
    required Uuid uuid,
  }) : _databaseHelper = databaseHelper,
       _uuid = uuid;
  
  @override
  Future<Result<AppUser>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final db = await _databaseHelper.database;
      
      // En SQLite no manejamos contraseñas, solo verificamos que el usuario exista
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.usersTable,
        where: 'email = ? AND is_active = ?',
        whereArgs: [email, 1],
      );
      
      if (maps.isEmpty) {
        return Result.failure(
          app_exceptions.AuthException(
            'Usuario no encontrado o inactivo',
            code: 'USER_NOT_FOUND',
          ),
        );
      }
      
      final user = AppUserModel.fromSqliteMap(maps.first);
      return Result.success(user);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al iniciar sesión: ${e.toString()}',
          code: 'SIGNIN_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<void>> signOut() async {
    try {
      // En SQLite no hay sesión persistente, solo retornamos éxito
      return Result.success(null);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al cerrar sesión: ${e.toString()}',
          code: 'SIGNOUT_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<AppUser?>> getCurrentUser() async {
    try {
      // En SQLite no hay concepto de usuario actual
      // Esta funcionalidad se manejará en la capa de presentación
      return Result.success(null);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener usuario actual: ${e.toString()}',
          code: 'GET_CURRENT_USER_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<bool>> isAuthenticated() async {
    try {
      // En SQLite no hay concepto de autenticación persistente
      return Result.success(false);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al verificar autenticación: ${e.toString()}',
          code: 'IS_AUTHENTICATED_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<AppUser>> signUp({
    required String email,
    required String password,
    required String fullName,
    required String role,
    required String branchId,
  }) async {
    try {
      final db = await _databaseHelper.database;
      
      // Verificar si el email ya existe
      final existingUsers = await db.query(
        AppConstants.usersTable,
        where: 'email = ?',
        whereArgs: [email],
      );
      
      if (existingUsers.isNotEmpty) {
        return Result.failure(
          app_exceptions.ValidationException(
            'El email ya está registrado',
            code: 'EMAIL_ALREADY_EXISTS',
          ),
        );
      }
      
      final user = AppUserModel.create(
        email: email,
        fullName: fullName,
        role: role,
        branchId: branchId,
      ).copyWith(id: _uuid.v4());
      
      await db.insert(
        AppConstants.usersTable,
        user.toSqliteMap(),
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      
      return Result.success(user);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al registrar usuario: ${e.toString()}',
          code: 'SIGNUP_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<AppUser>> updateProfile({
    required String userId,
    String? fullName,
    String? role,
    String? branchId,
    bool? isActive,
  }) async {
    try {
      final db = await _databaseHelper.database;
      
      // Obtener usuario actual
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.usersTable,
        where: 'id = ?',
        whereArgs: [userId],
      );
      
      if (maps.isEmpty) {
        return Result.failure(
          app_exceptions.NotFoundException(
            'Usuario no encontrado',
            code: 'USER_NOT_FOUND',
          ),
        );
      }
      
      final currentUser = AppUserModel.fromSqliteMap(maps.first);
      final updatedUser = currentUser.copyWith(
        fullName: fullName,
        role: role,
        branchId: branchId,
        isActive: isActive,
        updatedAt: DateTime.now(),
      ).markAsModified();
      
      await db.update(
        AppConstants.usersTable,
        updatedUser.toSqliteMap(),
        where: 'id = ?',
        whereArgs: [userId],
      );
      
      return Result.success(updatedUser);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al actualizar perfil: ${e.toString()}',
          code: 'UPDATE_PROFILE_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      // En SQLite no manejamos contraseñas
      return Result.failure(
        app_exceptions.ValidationException(
          'Cambio de contraseña no disponible en modo offline',
          code: 'OFFLINE_PASSWORD_CHANGE_NOT_SUPPORTED',
        ),
      );
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al cambiar contraseña: ${e.toString()}',
          code: 'CHANGE_PASSWORD_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<void>> resetPassword({
    required String email,
  }) async {
    try {
      // En SQLite no manejamos contraseñas
      return Result.failure(
        app_exceptions.ValidationException(
          'Restablecimiento de contraseña no disponible en modo offline',
          code: 'OFFLINE_PASSWORD_RESET_NOT_SUPPORTED',
        ),
      );
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al restablecer contraseña: ${e.toString()}',
          code: 'RESET_PASSWORD_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<AppUser>>> getAllUsers() async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.usersTable,
        orderBy: 'full_name ASC',
      );
      
      final users = maps
          .map((map) => AppUserModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(users);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener usuarios: ${e.toString()}',
          code: 'GET_ALL_USERS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<AppUser>>> getUsersByBranch(String branchId) async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.usersTable,
        where: 'branch_id = ? AND is_active = ?',
        whereArgs: [branchId, 1],
        orderBy: 'full_name ASC',
      );
      
      final users = maps
          .map((map) => AppUserModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(users);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener usuarios por sucursal: ${e.toString()}',
          code: 'GET_USERS_BY_BRANCH_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<AppUser>>> getUsersByRole(String role) async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.usersTable,
        where: 'role = ? AND is_active = ?',
        whereArgs: [role, 1],
        orderBy: 'full_name ASC',
      );
      
      final users = maps
          .map((map) => AppUserModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(users);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al obtener usuarios por rol: ${e.toString()}',
          code: 'GET_USERS_BY_ROLE_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<AppUser>>> searchUsers(String query) async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.usersTable,
        where: '(full_name LIKE ? OR email LIKE ?) AND is_active = ?',
        whereArgs: ['%$query%', '%$query%', 1],
        orderBy: 'full_name ASC',
      );
      
      final users = maps
          .map((map) => AppUserModel.fromSqliteMap(map))
          .toList();
      
      return Result.success(users);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al buscar usuarios: ${e.toString()}',
          code: 'SEARCH_USERS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<AppUser>> toggleUserStatus({
    required String userId,
    required bool isActive,
  }) async {
    try {
      final db = await _databaseHelper.database;
      
      // Obtener usuario actual
      final List<Map<String, dynamic>> maps = await db.query(
        AppConstants.usersTable,
        where: 'id = ?',
        whereArgs: [userId],
      );
      
      if (maps.isEmpty) {
        return Result.failure(
          app_exceptions.NotFoundException(
            'Usuario no encontrado',
            code: 'USER_NOT_FOUND',
          ),
        );
      }
      
      final currentUser = AppUserModel.fromSqliteMap(maps.first);
      final updatedUser = currentUser.copyWith(
        isActive: isActive,
        updatedAt: DateTime.now(),
      ).markAsModified();
      
      await db.update(
        AppConstants.usersTable,
        updatedUser.toSqliteMap(),
        where: 'id = ?',
        whereArgs: [userId],
      );
      
      return Result.success(updatedUser);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al cambiar estado del usuario: ${e.toString()}',
          code: 'TOGGLE_USER_STATUS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<void>> deleteUser(String userId) async {
    try {
      final db = await _databaseHelper.database;
      
      // Soft delete: marcar como inactivo
      final updatedUser = {
        'is_active': 0,
        'updated_at': DateTime.now().toIso8601String(),
        'synced': 0,
      };
      
      final rowsAffected = await db.update(
        AppConstants.usersTable,
        updatedUser,
        where: 'id = ?',
        whereArgs: [userId],
      );
      
      if (rowsAffected == 0) {
        return Result.failure(
          app_exceptions.NotFoundException(
            'Usuario no encontrado',
            code: 'USER_NOT_FOUND',
          ),
        );
      }
      
      return Result.success(null);
    } catch (e) {
      return Result.failure(
        app_exceptions.DatabaseException(
          'Error al eliminar usuario: ${e.toString()}',
          code: 'DELETE_USER_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<void>> syncUsers() async {
    try {
      // La sincronización se manejará en un servicio separado
      return Result.success(null);
    } catch (e) {
      return Result.failure(
        app_exceptions.SyncException(
          'Error al sincronizar usuarios: ${e.toString()}',
          code: 'SYNC_USERS_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<bool>> getSyncStatus() async {
    try {
      final db = await _databaseHelper.database;
      
      final List<Map<String, dynamic>> unsyncedUsers = await db.query(
        AppConstants.usersTable,
        where: 'synced = ?',
        whereArgs: [0],
        limit: 1,
      );
      
      // Si no hay usuarios sin sincronizar, está sincronizado
      final isSynced = unsyncedUsers.isEmpty;
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
}