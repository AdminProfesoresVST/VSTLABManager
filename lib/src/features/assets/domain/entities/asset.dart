import 'package:json_annotation/json_annotation.dart';

part 'asset.g.dart';

/// Entidad que representa un activo del laboratorio
@JsonSerializable()
class Asset {
  /// Identificador único del activo
  final String id;
  
  /// Nombre del activo
  final String name;
  
  /// Descripción del activo
  final String? description;
  
  /// Valor monetario del activo
  final double value;
  
  /// Estado actual del activo (available, loaned, maintenance)
  final String status;
  
  /// ID de la sucursal donde se encuentra el activo
  final String branchId;
  
  /// Código QR único del activo
  final String qrCode;
  
  /// URL de la imagen del activo (opcional)
  final String? imageUrl;
  
  /// Fecha de creación
  final DateTime createdAt;
  
  /// Fecha de última actualización
  final DateTime updatedAt;
  
  /// Constructor
  const Asset({
    required this.id,
    required this.name,
    this.description,
    required this.value,
    required this.status,
    required this.branchId,
    required this.qrCode,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });
  
  /// Constructor para crear un nuevo activo
  factory Asset.create({
    required String id,
    required String name,
    String? description,
    required double value,
    required String branchId,
    required String qrCode,
    String? imageUrl,
  }) {
    final now = DateTime.now();
    return Asset(
      id: id,
      name: name,
      description: description,
      value: value,
      status: 'available',
      branchId: branchId,
      qrCode: qrCode,
      imageUrl: imageUrl,
      createdAt: now,
      updatedAt: now,
    );
  }
  
  /// Deserialización desde JSON
  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
  
  /// Serialización a JSON
  Map<String, dynamic> toJson() => _$AssetToJson(this);
  
  /// Crea una copia con campos modificados
  Asset copyWith({
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
  }) {
    return Asset(
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
    );
  }
  
  /// Verifica si el activo está disponible
  bool get isAvailable => status == 'available';
  
  /// Verifica si el activo está prestado
  bool get isLoaned => status == 'loaned';
  
  /// Verifica si el activo está en mantenimiento
  bool get isInMaintenance => status == 'maintenance';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Asset && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
  
  @override
  String toString() {
    return 'Asset(id: $id, name: $name, status: $status, value: $value)';
  }
}