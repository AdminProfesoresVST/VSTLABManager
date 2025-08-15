/// Excepciones personalizadas para la aplicación VSTLABManager

/// Excepción base para todas las excepciones de la aplicación
abstract class AppException implements Exception {
  /// Mensaje de error legible para el usuario
  final String message;
  
  /// Código de error interno
  final String? code;
  
  const AppException(this.message, {this.code});
  
  @override
  String toString() => 'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Excepción para errores de red
class NetworkException extends AppException {
  const NetworkException(super.message, {super.code});
}

/// Excepción para errores de autenticación
class AuthException extends AppException {
  const AuthException(super.message, {super.code});
}

/// Excepción para errores de base de datos local
class DatabaseException extends AppException {
  const DatabaseException(super.message, {super.code});
}

/// Excepción para errores de validación
class ValidationException extends AppException {
  const ValidationException(super.message, {super.code});
}

/// Excepción para recursos no encontrados
class NotFoundException extends AppException {
  const NotFoundException(super.message, {super.code});
}

/// Excepción para operaciones no permitidas
class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message, {super.code});
}

/// Excepción para errores de sincronización
class SyncException extends AppException {
  const SyncException(super.message, {super.code});
}

/// Excepción para errores de QR
class QrException extends AppException {
  const QrException(super.message, {super.code});
}

/// Excepción para errores de permisos
class PermissionException extends AppException {
  const PermissionException(super.message, {super.code});
}