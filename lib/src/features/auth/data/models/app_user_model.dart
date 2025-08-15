import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/app_user.dart';

part 'app_user_model.g.dart';

/// Modelo de datos para AppUser con funcionalidades adicionales para persistencia
@JsonSerializable()
class AppUserModel extends AppUser {
  /// Campo adicional para sincronización
  @JsonKey(name: 'synced', defaultValue: false)
  final bool synced;
  
  /// Campo adicional para tracking de cambios locales
  @JsonKey(name: 'local_changes', defaultValue: false)
  final bool localChanges;
  
  const AppUserModel({
    required super.id,
    required super.email,
    required super.fullName,
    required super.role,
    required super.branchId,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
    this.synced = false,
    this.localChanges = false,
  });
  
  /// Constructor desde entidad de dominio
  factory AppUserModel.fromEntity(AppUser user) {
    return AppUserModel(
      id: user.id,
      email: user.email,
      fullName: user.fullName,
      role: user.role,
      branchId: user.branchId,
      isActive: user.isActive,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }
  
  /// Constructor para crear un nuevo usuario
  factory AppUserModel.create({
    required String email,
    required String fullName,
    required String role,
    required String branchId,
    bool isActive = true,
  }) {
    final now = DateTime.now();
    return AppUserModel(
      id: '', // Se asignará en el repositorio
      email: email,
      fullName: fullName,
      role: role,
      branchId: branchId,
      isActive: isActive,
      createdAt: now,
      updatedAt: now,
      localChanges: true,
    );
  }
  
  /// Deserialización desde JSON
  factory AppUserModel.fromJson(Map<String, dynamic> json) =>
      _$AppUserModelFromJson(json);
  
  /// Serialización a JSON
  @override
  Map<String, dynamic> toJson() => _$AppUserModelToJson(this);
  
  /// Convierte a Map para SQLite
  Map<String, dynamic> toSqliteMap() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'role': role,
      'branch_id': branchId,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'synced': synced ? 1 : 0,
    };
  }
  
  /// Constructor desde Map de SQLite
  factory AppUserModel.fromSqliteMap(Map<String, dynamic> map) {
    return AppUserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      fullName: map['full_name'] as String,
      role: map['role'] as String,
      branchId: map['branch_id'] as String,
      isActive: (map['is_active'] as int) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      synced: (map['synced'] as int?) == 1,
    );
  }
  
  /// Convierte a Map para Supabase
  Map<String, dynamic> toSupabaseMap() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'role': role,
      'branch_id': branchId,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
  
  /// Constructor desde Map de Supabase
  factory AppUserModel.fromSupabaseMap(Map<String, dynamic> map) {
    return AppUserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      fullName: map['full_name'] as String,
      role: map['role'] as String,
      branchId: map['branch_id'] as String,
      isActive: map['is_active'] as bool,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      synced: true, // Los datos de Supabase están sincronizados
    );
  }
  
  /// Crea una copia con cambios
  @override
  AppUserModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? role,
    String? branchId,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? synced,
    bool? localChanges,
  }) {
    return AppUserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      branchId: branchId ?? this.branchId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      synced: synced ?? this.synced,
      localChanges: localChanges ?? this.localChanges,
    );
  }
  
  /// Marca como sincronizado
  AppUserModel markAsSynced() {
    return copyWith(
      synced: true,
      localChanges: false,
    );
  }
  
  /// Marca como modificado localmente
  AppUserModel markAsModified() {
    return copyWith(
      localChanges: true,
      synced: false,
      updatedAt: DateTime.now(),
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppUserModel &&
        other.id == id &&
        other.email == email &&
        other.fullName == fullName &&
        other.role == role &&
        other.branchId == branchId &&
        other.isActive == isActive &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.synced == synced &&
        other.localChanges == localChanges;
  }
  
  @override
  int get hashCode {
    return Object.hash(
      id,
      email,
      fullName,
      role,
      branchId,
      isActive,
      createdAt,
      updatedAt,
      synced,
      localChanges,
    );
  }
  
  @override
  String toString() {
    return 'AppUserModel(id: $id, email: $email, fullName: $fullName, role: $role, branchId: $branchId, isActive: $isActive, synced: $synced, localChanges: $localChanges)';
  }
}