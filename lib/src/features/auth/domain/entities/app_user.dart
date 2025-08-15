import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

/// Entidad que representa un usuario de la aplicación
@JsonSerializable()
class AppUser {
  /// Identificador único del usuario
  final String id;
  
  /// Correo electrónico del usuario
  final String email;
  
  /// Nombre completo del usuario
  final String fullName;
  
  /// Rol del usuario en el sistema
  final String role;
  
  /// ID de la sucursal a la que pertenece el usuario
  final String branchId;
  
  /// Indica si el usuario está activo
  final bool isActive;
  
  /// Fecha de creación del usuario
  final DateTime createdAt;
  
  /// Fecha de última actualización
  final DateTime updatedAt;
  
  /// Constructor
  const AppUser({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.branchId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  
  /// Constructor para crear un nuevo usuario
  factory AppUser.create({
    required String id,
    required String email,
    required String fullName,
    required String role,
    required String branchId,
  }) {
    final now = DateTime.now();
    return AppUser(
      id: id,
      email: email,
      fullName: fullName,
      role: role,
      branchId: branchId,
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );
  }
  
  /// Deserialización desde JSON
  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
  
  /// Serialización a JSON
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
  
  /// Crea una copia con campos modificados
  AppUser copyWith({
    String? id,
    String? email,
    String? fullName,
    String? role,
    String? branchId,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppUser(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      branchId: branchId ?? this.branchId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  /// Verifica si el usuario es administrador
  bool get isAdmin => role == 'admin';
  
  /// Verifica si el usuario es supervisor
  bool get isSupervisor => role == 'supervisor';
  
  /// Verifica si el usuario es operador
  bool get isOperator => role == 'operator';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppUser && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
  
  @override
  String toString() {
    return 'AppUser(id: $id, email: $email, fullName: $fullName, role: $role)';
  }
}