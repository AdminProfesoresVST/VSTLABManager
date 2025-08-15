import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/auth_repository_supabase.dart';

/// Provider para el repositorio de autenticación
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositorySupabase();
});

/// Estado de autenticación que contiene información del usuario y estado de carga
class AuthState {
  /// Usuario autenticado actual
  final AppUser? user;
  
  /// Indica si hay una operación de autenticación en progreso
  final bool isLoading;
  
  /// Mensaje de error si ocurrió algún problema
  final String? error;
  
  /// Indica si el usuario está autenticado
  final bool isAuthenticated;

  /// Constructor del estado de autenticación
  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
  });

  /// Crea una copia del estado con los valores proporcionados
  AuthState copyWith({
    AppUser? user,
    bool? isLoading,
    String? error,
    bool? isAuthenticated,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

/// Notificador de estado de autenticación que maneja todas las operaciones de auth
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  /// Constructor que inicializa el notificador y verifica el estado de autenticación
  AuthNotifier(this._authRepository) : super(const AuthState()) {
    _checkAuthStatus();
  }

  /// Verificar estado de autenticación al inicializar
  Future<void> _checkAuthStatus() async {
    state = state.copyWith(isLoading: true);
    
    final result = await _authRepository.getCurrentUser();
    
    if (result.isSuccess) {
      final user = result.data;
      state = state.copyWith(
        isLoading: false,
        user: user,
        isAuthenticated: user != null,
        error: null,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.exception?.message,
        isAuthenticated: false,
      );
    }
  }

  /// Iniciar sesión con email y contraseña
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await _authRepository.signIn(
      email: email,
      password: password,
    );
    
    if (result.isSuccess) {
      final user = result.data!;
      state = state.copyWith(
        isLoading: false,
        user: user,
        isAuthenticated: true,
        error: null,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.exception?.message,
        isAuthenticated: false,
      );
    }
  }

  /// Registrar nuevo usuario
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String fullName,
    required String role,
    required String branchId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await _authRepository.signUp(
      email: email,
      password: password,
      fullName: fullName,
      role: role,
      branchId: branchId,
    );
    
    if (result.isSuccess) {
      final user = result.data!;
      state = state.copyWith(
        isLoading: false,
        user: user,
        isAuthenticated: true,
        error: null,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.exception?.message,
        isAuthenticated: false,
      );
    }
  }

  /// Cerrar sesión
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await _authRepository.signOut();
    
    if (result.isSuccess) {
      state = state.copyWith(
        isLoading: false,
        user: null,
        isAuthenticated: false,
        error: null,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.exception?.message,
      );
    }
  }

  /// Restablecer contraseña
  Future<void> resetPassword(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await _authRepository.resetPassword(
      email: email,
    );
    
    if (result.isSuccess) {
      state = state.copyWith(
        isLoading: false,
        error: null,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.exception?.message,
      );
    }
  }

  /// Actualizar perfil de usuario
  Future<void> updateProfile({
    String? fullName,
    String? role,
    String? branchId,
    bool? isActive,
  }) async {
    if (state.user == null) return;
    
    state = state.copyWith(isLoading: true, error: null);
    
    final result = await _authRepository.updateProfile(
      userId: state.user!.id,
      fullName: fullName,
      role: role,
      branchId: branchId,
      isActive: isActive,
    );
    
    if (result.isSuccess) {
      final updatedUser = result.data!;
      state = state.copyWith(
        isLoading: false,
        user: updatedUser,
        error: null,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.exception?.message,
      );
    }
  }

  /// Limpiar errores
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Provider del notificador de autenticación
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository);
});

/// Provider para verificar si el usuario está autenticado
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.isAuthenticated;
});

/// Provider para obtener el usuario actual
final currentUserProvider = Provider<AppUser?>((ref) {
  final authState = ref.watch(authNotifierProvider);
  return authState.user;
});

/// Provider para verificar si el usuario es administrador
final isAdminProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.role == 'admin';
});

/// Provider para verificar si el usuario puede gestionar activos
final canManageAssetsProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.role == 'admin' || user?.role == 'manager';
});

/// Provider para obtener todos los usuarios
final allUsersProvider = FutureProvider<List<AppUser>>((ref) async {
  final repository = ref.watch(authRepositoryProvider);
  final result = await repository.getAllUsers();
  
  if (result.isSuccess) {
    return result.data ?? [];
  } else {
    throw result.exception ?? Exception('Error al cargar usuarios');
  }
});