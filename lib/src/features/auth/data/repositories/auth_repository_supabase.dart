import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/app_user_model.dart';
import '../../../../core/network/supabase_client.dart';
import '../../../../core/utils/result.dart';
import '../../../../core/exceptions/app_exceptions.dart' as app_exceptions;
import '../../../../shared/constants/app_constants.dart';

/// Implementación Supabase del repositorio de autenticación
class AuthRepositorySupabase implements AuthRepository {
  AuthRepositorySupabase();
  
  SupabaseClient get _supabase => SupabaseClientConfig.client;
  
  @override
  Future<Result<AppUser>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      if (response.user == null) {
        return Result.failure(
          app_exceptions.AuthException(
            'Error de autenticación',
            code: 'AUTH_ERROR',
          ),
        );
      }
      
      // Obtener datos del usuario desde la tabla users
      final userData = await _supabase
          .from(AppConstants.usersTable)
          .select()
          .eq('id', response.user!.id)
          .single();
      
      final user = AppUserModel.fromSupabaseMap(userData);
      return Result.success(user);
    } on AuthException catch (e) {
      return Result.failure(
        app_exceptions.AuthException(
          e.message,
          code: 'SUPABASE_AUTH_ERROR',
        ),
      );
    } on PostgrestException catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          e.message,
          code: 'SUPABASE_DB_ERROR',
        ),
      );
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error de conexión: ${e.toString()}',
          code: 'NETWORK_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<void>> signOut() async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      await _supabase.auth.signOut();
      return Result.success(null);
    } on AuthException catch (e) {
      return Result.failure(
        app_exceptions.AuthException(
          e.message,
          code: 'SUPABASE_AUTH_ERROR',
        ),
      );
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error de conexión: ${e.toString()}',
          code: 'NETWORK_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<AppUser?>> getCurrentUser() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        return Result.success(null);
      }
      
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      // Obtener datos del usuario desde la tabla users
      final userData = await _supabase
          .from(AppConstants.usersTable)
          .select()
          .eq('id', user.id)
          .single();
      
      final appUser = AppUserModel.fromSupabaseMap(userData);
      return Result.success(appUser);
    } on PostgrestException catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          e.message,
          code: 'SUPABASE_DB_ERROR',
        ),
      );
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error de conexión: ${e.toString()}',
          code: 'NETWORK_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<bool>> isAuthenticated() async {
    try {
      final user = _supabase.auth.currentUser;
      return Result.success(user != null);
    } catch (e) {
      return Result.failure(
        app_exceptions.AuthException(
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
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      // Crear usuario en Supabase Auth
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      
      if (response.user == null) {
        return Result.failure(
          app_exceptions.AuthException(
            'Error al crear usuario',
            code: 'SIGNUP_ERROR',
          ),
        );
      }
      
      // Crear registro en la tabla users
      final user = AppUserModel.create(
        email: email,
        fullName: fullName,
        role: role,
        branchId: branchId,
      ).copyWith(id: response.user!.id);
      
      await _supabase
          .from(AppConstants.usersTable)
          .insert(user.toSupabaseMap());
      
      return Result.success(user);
    } on AuthException catch (e) {
      return Result.failure(
        app_exceptions.AuthException(
          e.message,
          code: 'SUPABASE_AUTH_ERROR',
        ),
      );
    } on PostgrestException catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          e.message,
          code: 'SUPABASE_DB_ERROR',
        ),
      );
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error de conexión: ${e.toString()}',
          code: 'NETWORK_ERROR',
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
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final updateData = <String, dynamic>{
        'updated_at': DateTime.now().toIso8601String(),
      };
      
      if (fullName != null) updateData['full_name'] = fullName;
      if (role != null) updateData['role'] = role;
      if (branchId != null) updateData['branch_id'] = branchId;
      if (isActive != null) updateData['is_active'] = isActive;
      
      final response = await _supabase
          .from(AppConstants.usersTable)
          .update(updateData)
          .eq('id', userId)
          .select()
          .single();
      
      final user = AppUserModel.fromSupabaseMap(response);
      return Result.success(user);
    } on PostgrestException catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          e.message,
          code: 'SUPABASE_DB_ERROR',
        ),
      );
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error de conexión: ${e.toString()}',
          code: 'NETWORK_ERROR',
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
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      await _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
      
      return Result.success(null);
    } on AuthException catch (e) {
      return Result.failure(
        app_exceptions.AuthException(
          e.message,
          code: 'SUPABASE_AUTH_ERROR',
        ),
      );
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error de conexión: ${e.toString()}',
          code: 'NETWORK_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<void>> resetPassword({
    required String email,
  }) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      await _supabase.auth.resetPasswordForEmail(email);
      return Result.success(null);
    } on AuthException catch (e) {
      return Result.failure(
        app_exceptions.AuthException(
          e.message,
          code: 'SUPABASE_AUTH_ERROR',
        ),
      );
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error de conexión: ${e.toString()}',
          code: 'NETWORK_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<AppUser>>> getAllUsers() async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await _supabase
          .from(AppConstants.usersTable)
          .select()
          .order('full_name', ascending: true);
      
      final users = response
          .map((map) => AppUserModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(users);
    } on PostgrestException catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          e.message,
          code: 'SUPABASE_DB_ERROR',
        ),
      );
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error de conexión: ${e.toString()}',
          code: 'NETWORK_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<AppUser>>> getUsersByBranch(String branchId) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await _supabase
          .from(AppConstants.usersTable)
          .select()
          .eq('branch_id', branchId)
          .eq('is_active', true)
          .order('full_name', ascending: true);
      
      final users = response
          .map((map) => AppUserModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(users);
    } on PostgrestException catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          e.message,
          code: 'SUPABASE_DB_ERROR',
        ),
      );
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error de conexión: ${e.toString()}',
          code: 'NETWORK_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<AppUser>>> getUsersByRole(String role) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await _supabase
          .from(AppConstants.usersTable)
          .select()
          .eq('role', role)
          .eq('is_active', true)
          .order('full_name', ascending: true);
      
      final users = response
          .map((map) => AppUserModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(users);
    } on PostgrestException catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          e.message,
          code: 'SUPABASE_DB_ERROR',
        ),
      );
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error de conexión: ${e.toString()}',
          code: 'NETWORK_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<List<AppUser>>> searchUsers(String query) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await _supabase
          .from(AppConstants.usersTable)
          .select()
          .or('full_name.ilike.%$query%,email.ilike.%$query%')
          .eq('is_active', true)
          .order('full_name', ascending: true);
      
      final users = response
          .map((map) => AppUserModel.fromSupabaseMap(map))
          .toList();
      
      return Result.success(users);
    } on PostgrestException catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          e.message,
          code: 'SUPABASE_DB_ERROR',
        ),
      );
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error de conexión: ${e.toString()}',
          code: 'NETWORK_ERROR',
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
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      final response = await _supabase
          .from(AppConstants.usersTable)
          .update({
            'is_active': isActive,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', userId)
          .select()
          .single();
      
      final user = AppUserModel.fromSupabaseMap(response);
      return Result.success(user);
    } on PostgrestException catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          e.message,
          code: 'SUPABASE_DB_ERROR',
        ),
      );
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error de conexión: ${e.toString()}',
          code: 'NETWORK_ERROR',
        ),
      );
    }
  }
  
  @override
  Future<Result<void>> deleteUser(String userId) async {
    try {
      if (!await SupabaseClientConfig.hasInternetConnection()) {
        return Result.failure(
          app_exceptions.NetworkException(
            'Sin conexión a internet',
            code: 'NO_INTERNET_CONNECTION',
          ),
        );
      }
      
      // Soft delete: marcar como inactivo
      await _supabase
          .from(AppConstants.usersTable)
          .update({
            'is_active': false,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', userId);
      
      return Result.success(null);
    } on PostgrestException catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          e.message,
          code: 'SUPABASE_DB_ERROR',
        ),
      );
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error de conexión: ${e.toString()}',
          code: 'NETWORK_ERROR',
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
      // En Supabase, siempre está sincronizado cuando hay conexión
      final hasConnection = await SupabaseClientConfig.hasInternetConnection();
      return Result.success(hasConnection);
    } catch (e) {
      return Result.failure(
        app_exceptions.NetworkException(
          'Error al obtener estado de sincronización: ${e.toString()}',
          code: 'GET_SYNC_STATUS_ERROR',
        ),
      );
    }
  }
}