import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/asset.dart';

part 'asset_model.g.dart';

/// Modelo de datos para Asset con funcionalidades adicionales para persistencia
@JsonSerializable()
class AssetModel extends Asset {
  /// Campo adicional para sincronización
  @JsonKey(name: 'synced', defaultValue: false)
  final bool synced;
  
  /// Campo adicional para tracking de cambios locales
  @JsonKey(name: 'local_changes', defaultValue: false)
  final bool localChanges;
  
  const AssetModel({
    required super.id,
    required super.name,
    required super.description,
    required super.value,
    required super.status,
    required super.branchId,
    required super.qrCode,
    super.imageUrl,
    required super.createdAt,
    required super.updatedAt,
    this.synced = false,
    this.localChanges = false,
  });
  
  /// Constructor desde entidad de dominio
  factory AssetModel.fromEntity(Asset asset) {
    return AssetModel(
      id: asset.id,
      name: asset.name,
      description: asset.description,
      value: asset.value,
      status: asset.status,
      branchId: asset.branchId,
      qrCode: asset.qrCode,
      imageUrl: asset.imageUrl,
      createdAt: asset.createdAt,
      updatedAt: asset.updatedAt,
    );
  }
  
  /// Constructor para crear un nuevo activo
  factory AssetModel.create({
    required String name,
    required String description,
    required double value,
    required String branchId,
    required String qrCode,
    String? imageUrl,
  }) {
    final now = DateTime.now();
    return AssetModel(
      id: '', // Se asignará en el repositorio
      name: name,
      description: description,
      value: value,
      status: 'available',
      branchId: branchId,
      qrCode: qrCode,
      imageUrl: imageUrl,
      createdAt: now,
      updatedAt: now,
      localChanges: true,
    );
  }
  
  /// Deserialización desde JSON
  factory AssetModel.fromJson(Map<String, dynamic> json) =>
      _$AssetModelFromJson(json);
  
  /// Serialización a JSON
  @override
  Map<String, dynamic> toJson() => _$AssetModelToJson(this);
  
  /// Convierte a Map para SQLite
  Map<String, dynamic> toSqliteMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'value': value,
      'status': status,
      'branch_id': branchId,
      'qr_code': qrCode,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'synced': synced ? 1 : 0,
    };
  }
  
  /// Constructor desde Map de SQLite
  factory AssetModel.fromSqliteMap(Map<String, dynamic> map) {
    return AssetModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String? ?? '',
      value: (map['value'] as num).toDouble(),
      status: map['status'] as String,
      branchId: map['branch_id'] as String,
      qrCode: map['qr_code'] as String,
      imageUrl: map['image_url'] as String?,
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
      'description': description,
      'value': value,
      'status': status,
      'branch_id': branchId,
      'qr_code': qrCode,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
  
  /// Constructor desde Map de Supabase
  factory AssetModel.fromSupabaseMap(Map<String, dynamic> map) {
    return AssetModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String? ?? '',
      value: (map['value'] as num).toDouble(),
      status: map['status'] as String,
      branchId: map['branch_id'] as String,
      qrCode: map['qr_code'] as String,
      imageUrl: map['image_url'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      synced: true, // Los datos de Supabase están sincronizados
    );
  }
  
  /// Crea una copia con cambios
  @override
  AssetModel copyWith({
    String? id,
    String? name,
    String? description,
    double? value,
    String? status,
    String? branchId,
    String? qrCode,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? synced,
    bool? localChanges,
  }) {
    return AssetModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      value: value ?? this.value,
      status: status ?? this.status,
      branchId: branchId ?? this.branchId,
      qrCode: qrCode ?? this.qrCode,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      synced: synced ?? this.synced,
      localChanges: localChanges ?? this.localChanges,
    );
  }
  
  /// Marca como sincronizado
  AssetModel markAsSynced() {
    return copyWith(
      synced: true,
      localChanges: false,
    );
  }
  
  /// Marca como modificado localmente
  AssetModel markAsModified() {
    return copyWith(
      localChanges: true,
      synced: false,
      updatedAt: DateTime.now(),
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AssetModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.value == value &&
        other.status == status &&
        other.branchId == branchId &&
        other.qrCode == qrCode &&
        other.imageUrl == imageUrl &&
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
      description,
      value,
      status,
      branchId,
      qrCode,
      imageUrl,
      createdAt,
      updatedAt,
      synced,
      localChanges,
    );
  }
  
  @override
  String toString() {
    return 'AssetModel(id: $id, name: $name, status: $status, branchId: $branchId, synced: $synced, localChanges: $localChanges)';
  }
}