import 'package:json_annotation/json_annotation.dart';

part 'branch.g.dart';

/// Entidad que representa una sucursal o ubicación física
@JsonSerializable()
class Branch {
  /// Identificador único de la sucursal
  final String id;
  
  /// Nombre de la sucursal
  final String name;
  
  /// Dirección física de la sucursal
  final String address;
  
  /// Código interno de la sucursal
  final String code;
  
  /// Indica si la sucursal está activa
  final bool isActive;
  
  /// Fecha de creación
  final DateTime createdAt;
  
  /// Fecha de última actualización
  final DateTime updatedAt;
  
  /// Constructor
  const Branch({
    required this.id,
    required this.name,
    required this.address,
    required this.code,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  
  /// Constructor para crear una nueva sucursal
  factory Branch.create({
    required String id,
    required String name,
    required String address,
    required String code,
  }) {
    final now = DateTime.now();
    return Branch(
      id: id,
      name: name,
      address: address,
      code: code,
      isActive: true,
      createdAt: now,
      updatedAt: now,
    );
  }
  
  /// Deserialización desde JSON
  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);
  
  /// Serialización a JSON
  Map<String, dynamic> toJson() => _$BranchToJson(this);
  
  /// Crea una copia con campos modificados
  Branch copyWith({
    String? id,
    String? name,
    String? address,
    String? code,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Branch(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      code: code ?? this.code,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Branch && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
  
  @override
  String toString() {
    return 'Branch(id: $id, name: $name, code: $code, isActive: $isActive)';
  }
}