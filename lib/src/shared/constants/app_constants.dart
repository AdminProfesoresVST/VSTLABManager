/// Constantes globales de la aplicación VSTLABManager
class AppConstants {
  // Configuración de la aplicación
  static const String appName = 'VSTLABManager';
  static const String appVersion = '1.0.0';
  
  // Base de datos local
  static const String localDatabaseName = 'vstlab_local.db';
  static const int localDatabaseVersion = 1;
  
  // Tablas de la base de datos
  static const String usersTable = 'profiles';
  static const String assetsTable = 'assets';
  static const String loansTable = 'loans';
  static const String branchesTable = 'branches';
  
  // Estados de activos
  static const String assetStatusAvailable = 'available';
  static const String assetStatusLoaned = 'loaned';
  static const String assetStatusMaintenance = 'maintenance';
  
  // Estados de préstamos
  static const String loanStatusActive = 'active';
  static const String loanStatusClosed = 'closed';
  static const String loanStatusOverdue = 'overdue';
  
  // Roles de usuario
  static const String roleOperator = 'operator';
  static const String roleSupervisor = 'supervisor';
  static const String roleAdmin = 'admin';
  
  // Configuración de UI
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  
  // Configuración de QR
  static const double qrCodeSize = 200.0;
  static const String qrCodePrefix = 'VSTLAB_';
  
  // Timeouts y límites
  static const int networkTimeoutSeconds = 30;
  static const int syncRetryAttempts = 3;
  static const int maxAssetsPerPage = 50;
  
  // Mensajes de error
  static const String errorNetworkConnection = 'Error de conexión de red';
  static const String errorInvalidCredentials = 'Credenciales inválidas';
  static const String errorAssetNotFound = 'Activo no encontrado';
  static const String errorQrInvalid = 'Código QR inválido';
  
  // Mensajes de éxito
  static const String successAssetCreated = 'Activo creado exitosamente';
  static const String successLoanRegistered = 'Préstamo registrado exitosamente';
  static const String successAssetReturned = 'Activo devuelto exitosamente';
}