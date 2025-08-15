import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/loan.dart';

part 'loan_model.g.dart';

/// Modelo de datos para Loan con funcionalidades adicionales para persistencia
@JsonSerializable()
class LoanModel extends Loan {
  /// Campo adicional para sincronización
  @JsonKey(name: 'synced', defaultValue: false)
  final bool synced;
  
  /// Campo adicional para tracking de cambios locales
  @JsonKey(name: 'local_changes', defaultValue: false)
  final bool localChanges;
  
  const LoanModel({
    required super.id,
    required super.assetId,
    required super.borrowerId,
    required super.lenderId,
    required super.startDate,
    required super.expectedReturnDate,
    super.actualReturnDate,
    required super.status,
    super.notes,
    required super.createdAt,
    required super.updatedAt,
    this.synced = false,
    this.localChanges = false,
  });
  
  /// Constructor desde entidad de dominio
  factory LoanModel.fromEntity(Loan loan) {
    return LoanModel(
      id: loan.id,
      assetId: loan.assetId,
      borrowerId: loan.borrowerId,
      lenderId: loan.lenderId,
      startDate: loan.startDate,
      expectedReturnDate: loan.expectedReturnDate,
      actualReturnDate: loan.actualReturnDate,
      status: loan.status,
      notes: loan.notes,
      createdAt: loan.createdAt,
      updatedAt: loan.updatedAt,
    );
  }
  
  /// Constructor para crear un nuevo préstamo
  factory LoanModel.create({
    required String assetId,
    required String borrowerId,
    required String lenderId,
    required DateTime startDate,
    required DateTime expectedReturnDate,
    String? notes,
  }) {
    final now = DateTime.now();
    return LoanModel(
      id: '', // Se asignará en el repositorio
      assetId: assetId,
      borrowerId: borrowerId,
      lenderId: lenderId,
      startDate: startDate,
      expectedReturnDate: expectedReturnDate,
      status: 'active',
      notes: notes,
      createdAt: now,
      updatedAt: now,
      localChanges: true,
    );
  }
  
  /// Deserialización desde JSON
  factory LoanModel.fromJson(Map<String, dynamic> json) =>
      _$LoanModelFromJson(json);
  
  /// Serialización a JSON
  @override
  Map<String, dynamic> toJson() => _$LoanModelToJson(this);
  
  /// Convierte a Map para SQLite
  Map<String, dynamic> toSqliteMap() {
    return {
      'id': id,
      'asset_id': assetId,
      'borrower_id': borrowerId,
      'lender_id': lenderId,
      'start_date': startDate.toIso8601String(),
      'expected_return_date': expectedReturnDate.toIso8601String(),
      'actual_return_date': actualReturnDate?.toIso8601String(),
      'status': status,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'synced': synced ? 1 : 0,
    };
  }
  
  /// Constructor desde Map de SQLite
  factory LoanModel.fromSqliteMap(Map<String, dynamic> map) {
    return LoanModel(
      id: map['id'] as String,
      assetId: map['asset_id'] as String,
      borrowerId: map['borrower_id'] as String,
      lenderId: map['lender_id'] as String,
      startDate: DateTime.parse(map['start_date'] as String),
      expectedReturnDate: DateTime.parse(map['expected_return_date'] as String),
      actualReturnDate: map['actual_return_date'] != null
          ? DateTime.parse(map['actual_return_date'] as String)
          : null,
      status: map['status'] as String,
      notes: map['notes'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      synced: (map['synced'] as int?) == 1,
    );
  }
  
  /// Convierte a Map para Supabase
  Map<String, dynamic> toSupabaseMap() {
    return {
      'id': id,
      'asset_id': assetId,
      'borrower_id': borrowerId,
      'lender_id': lenderId,
      'start_date': startDate.toIso8601String(),
      'expected_return_date': expectedReturnDate.toIso8601String(),
      'actual_return_date': actualReturnDate?.toIso8601String(),
      'status': status,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
  
  /// Constructor desde Map de Supabase
  factory LoanModel.fromSupabaseMap(Map<String, dynamic> map) {
    return LoanModel(
      id: map['id'] as String,
      assetId: map['asset_id'] as String,
      borrowerId: map['borrower_id'] as String,
      lenderId: map['lender_id'] as String,
      startDate: DateTime.parse(map['start_date'] as String),
      expectedReturnDate: DateTime.parse(map['expected_return_date'] as String),
      actualReturnDate: map['actual_return_date'] != null
          ? DateTime.parse(map['actual_return_date'] as String)
          : null,
      status: map['status'] as String,
      notes: map['notes'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
      synced: true, // Los datos de Supabase están sincronizados
    );
  }
  
  /// Crea una copia con cambios
  @override
  LoanModel copyWith({
    String? id,
    String? assetId,
    String? borrowerId,
    String? lenderId,
    DateTime? startDate,
    DateTime? expectedReturnDate,
    DateTime? actualReturnDate,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? synced,
    bool? localChanges,
  }) {
    return LoanModel(
      id: id ?? this.id,
      assetId: assetId ?? this.assetId,
      borrowerId: borrowerId ?? this.borrowerId,
      lenderId: lenderId ?? this.lenderId,
      startDate: startDate ?? this.startDate,
      expectedReturnDate: expectedReturnDate ?? this.expectedReturnDate,
      actualReturnDate: actualReturnDate ?? this.actualReturnDate,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      synced: synced ?? this.synced,
      localChanges: localChanges ?? this.localChanges,
    );
  }
  
  /// Marca como sincronizado
  LoanModel markAsSynced() {
    return copyWith(
      synced: true,
      localChanges: false,
    );
  }
  
  /// Marca como modificado localmente
  LoanModel markAsModified() {
    return copyWith(
      localChanges: true,
      synced: false,
      updatedAt: DateTime.now(),
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoanModel &&
        other.id == id &&
        other.assetId == assetId &&
        other.borrowerId == borrowerId &&
        other.lenderId == lenderId &&
        other.startDate == startDate &&
        other.expectedReturnDate == expectedReturnDate &&
        other.actualReturnDate == actualReturnDate &&
        other.status == status &&
        other.notes == notes &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.synced == synced &&
        other.localChanges == localChanges;
  }
  
  @override
  int get hashCode {
    return Object.hash(
      id,
      assetId,
      borrowerId,
      lenderId,
      startDate,
      expectedReturnDate,
      actualReturnDate,
      status,
      notes,
      createdAt,
      updatedAt,
      synced,
      localChanges,
    );
  }
  
  @override
  String toString() {
    return 'LoanModel(id: $id, assetId: $assetId, borrowerId: $borrowerId, status: $status, synced: $synced, localChanges: $localChanges)';
  }
}