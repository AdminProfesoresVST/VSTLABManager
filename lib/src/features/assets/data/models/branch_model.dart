import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/branch.dart';

part 'branch_model.g.dart';

/// Modelo de datos para Branch con funcionalidades adicionales para persistencia
@JsonSerializable()
class BranchModel extends Branch {
  /// Campo adicional para sincronización
  @JsonKey(name: 'synced', defaultValue: false)
  final bool synced;
  
  /// Campo adicional para tracking de cambios locales
  @JsonKey(name: 'local_changes', defaultValue: false)
  final bool localChanges;
  
  const BranchModel({
    required super.id,
    required super.name,
    required super.address,
    required super.code,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
    this.synced = false,
    this.localChanges = false,
  });
  
  /// Constructor desde entidad de dominio
  factory BranchModel.fromEntity(Branch branch) {
    return BranchModel(
      id: branch.id,
      name: branch.name,
      address: branch.address,
      code: branch.code,
      isActive: branch.isActive,
      createdAt: branch.createdAt,
      updatedAt: branch.updatedAt,
    );
  }
  
  /// Constructor para crear una nueva sucursal
  factory BranchModel.create({
    required String name,
    required String address,
    required String code,
    bool isActive = true,
  }) {
    final now = DateTime.now();
    return BranchModel(
      id: '', // Se asignará en el repositorio
      name: name,
      address: address,
      code: code,
      isActive: isActive,
      createdAt: now,
      updatedAt: now,
      localChanges: true,
    );
  }
  
  /// Deserialización desde JSON
  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);
  
  /// Serialización a JSON
  @override
  Map<String, dynamic> toJson() => _$BranchModelToJson(this);
  
  /// Convierte a Map para SQLite
  Map<String, dynamic> toSqliteMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'code': code,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'synced': synced ? 1 : 0,
    };
  }
  
  /// Constructor desde Map de SQLite
  factory BranchModel.fromSqliteMap(Map<String, dynamic> map) {
    return BranchModel(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      code: map['code'] as String,
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
      'name': name,
      'address': address,
      'code': code,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
  
  /// Constructor desde Map de Supabase
  factory BranchModel.fromSupabaseMap(Map<String, dynamic> map) {
    return BranchModel(
      id: map['id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      code: map['code'] as String,
      isActive: map['is_active'] as bool,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      synced: true, // Los datos de Supabase están sincronizados
    );
  }
  
  /// Crea una copia con cambios
  @override
  BranchModel copyWith({
    String? id,
    String? name,
    String? address,
    String? code,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? synced,
    bool? localChanges,
  }) {
    return BranchModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      code: code ?? this.code,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      synced: synced ?? this.synced,
      localChanges: localChanges ?? this.localChanges,
    );
  }
  
  /// Marca como sincronizado
  BranchModel markAsSynced() {
    return copyWith(
      synced: true,
      localChanges: false,
    );
  }
  
  /// Marca como modificado localmente
  BranchModel markAsModified() {
    return copyWith(
      localChanges: true,
      synced: false,
      updatedAt: DateTime.now(),
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BranchModel &&
        other.id == id &&
        other.name == name &&
        other.address == address &&
        other.code == code &&
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
      name,
      address,
      code,
      isActive,
      createdAt,
      updatedAt,
      synced,
      localChanges,
    );
  }
  
  @override
  String toString() {
    return 'BranchModel(id: $id, name: $name, code: $code, isActive: $isActive, synced: $synced, localChanges: $localChanges)';
  }
}