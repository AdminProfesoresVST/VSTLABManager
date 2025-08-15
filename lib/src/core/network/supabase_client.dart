import 'package:supabase_flutter/supabase_flutter.dart';
import '../exceptions/app_exceptions.dart' as app_exceptions;

/// Cliente configurado para Supabase
class SupabaseClientConfig {
  static SupabaseClient? _client;
  
  /// URL de Supabase (debe ser configurada en variables de entorno)
  static const String _supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://your-project.supabase.co',
  );
  
  /// Clave anónima de Supabase (debe ser configurada en variables de entorno)
  static const String _supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'your-anon-key',
  );
  
  /// Inicializa Supabase
  static Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: _supabaseUrl,
        anonKey: _supabaseAnonKey,
        debug: false, // Cambiar a true solo en desarrollo
      );
      _client = Supabase.instance.client;
    } catch (e) {
      throw app_exceptions.NetworkException(
        'Error al inicializar Supabase: ${e.toString()}',
        code: 'SUPABASE_INIT_ERROR',
      );
    }
  }
  
  /// Obtiene la instancia del cliente Supabase
  static SupabaseClient get client {
    if (_client == null) {
      throw app_exceptions.NetworkException(
        'Supabase no ha sido inicializado. Llama a initialize() primero.',
        code: 'SUPABASE_NOT_INITIALIZED',
      );
    }
    return _client!;
  }
  
  /// Verifica si hay conexión a internet
  static Future<bool> hasInternetConnection() async {
    try {
      // Usar una consulta simple que no dependa de tablas específicas
      final response = await client
          .from('profiles')
          .select('id')
          .limit(1)
          .timeout(const Duration(seconds: 5));
      return true;
    } catch (e) {
      // Si falla, intentar con una consulta aún más básica
      try {
        await client.auth.getUser();
        return true;
      } catch (e2) {
        return false;
      }
    }
  }
  
  /// Obtiene el usuario autenticado actual
  static User? get currentUser => client.auth.currentUser;
  
  /// Verifica si el usuario está autenticado
  static bool get isAuthenticated => currentUser != null;
  
  /// Cierra la sesión del usuario
  static Future<void> signOut() async {
    try {
      await client.auth.signOut();
    } catch (e) {
      throw app_exceptions.AuthException(
        'Error al cerrar sesión: ${e.toString()}',
        code: 'SIGN_OUT_ERROR',
      );
    }
  }
}

/// Extensión para manejo de errores de Supabase
extension SupabaseErrorHandler on PostgrestException {
  /// Convierte un error de Supabase a una excepción de la aplicación
  app_exceptions.AppException toAppException() {
    switch (code) {
      case '23505': // Violación de restricción única
        return app_exceptions.ValidationException(
          'Ya existe un registro con estos datos',
          code: code,
        );
      case '23503': // Violación de clave foránea
        return app_exceptions.ValidationException(
          'Referencia inválida a otro registro',
          code: code,
        );
      case '42P01': // Tabla no existe
        return app_exceptions.DatabaseException(
          'Error de configuración de base de datos',
          code: code,
        );
      default:
        return app_exceptions.NetworkException(
          message,
          code: code,
        );
    }
  }
}

/// Extensión para manejo de errores de autenticación
extension AuthErrorHandler on AuthException {
  /// Convierte un error de autenticación a una excepción de la aplicación
  app_exceptions.AppException toAppException() {
    switch (message) {
      case 'Invalid login credentials':
        return app_exceptions.AuthException(
          'Credenciales inválidas',
          code: 'INVALID_CREDENTIALS',
        );
      case 'Email not confirmed':
        return app_exceptions.AuthException(
          'Email no confirmado',
          code: 'EMAIL_NOT_CONFIRMED',
        );
      case 'User not found':
        return app_exceptions.AuthException(
          'Usuario no encontrado',
          code: 'USER_NOT_FOUND',
        );
      default:
        return app_exceptions.AuthException(
          message,
          code: 'AUTH_ERROR',
        );
    }
  }
}