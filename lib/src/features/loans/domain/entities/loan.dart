import 'package:json_annotation/json_annotation.dart';

part 'loan.g.dart';

/// Entidad que representa un préstamo de activo
@JsonSerializable()
class Loan {
  /// Identificador único del préstamo
  final String id;
  
  /// ID del activo prestado
  final String assetId;
  
  /// ID del usuario responsable del préstamo
  final String borrowerId;
  
  /// ID del usuario que registró el préstamo
  final String lenderId;
  
  /// Fecha de inicio del préstamo
  final DateTime startDate;
  
  /// Fecha esperada de devolución
  final DateTime expectedReturnDate;
  
  /// Fecha real de devolución (null si aún no se ha devuelto)
  final DateTime? actualReturnDate;
  
  /// Estado del préstamo (active, closed, overdue)
  final String status;
  
  /// Notas adicionales del préstamo
  final String? notes;
  
  /// Fecha de creación
  final DateTime createdAt;
  
  /// Fecha de última actualización
  final DateTime updatedAt;
  
  /// Constructor
  const Loan({
    required this.id,
    required this.assetId,
    required this.borrowerId,
    required this.lenderId,
    required this.startDate,
    required this.expectedReturnDate,
    this.actualReturnDate,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  
  /// Constructor para crear un nuevo préstamo
  factory Loan.create({
    required String id,
    required String assetId,
    required String borrowerId,
    required String lenderId,
    required DateTime expectedReturnDate,
    String? notes,
  }) {
    final now = DateTime.now();
    return Loan(
      id: id,
      assetId: assetId,
      borrowerId: borrowerId,
      lenderId: lenderId,
      startDate: now,
      expectedReturnDate: expectedReturnDate,
      actualReturnDate: null,
      status: 'active',
      notes: notes,
      createdAt: now,
      updatedAt: now,
    );
  }
  
  /// Deserialización desde JSON
  factory Loan.fromJson(Map<String, dynamic> json) => _$LoanFromJson(json);
  
  /// Serialización a JSON
  Map<String, dynamic> toJson() => _$LoanToJson(this);
  
  /// Crea una copia con campos modificados
  Loan copyWith({
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
  }) {
    return Loan(
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
    );
  }
  
  /// Verifica si el préstamo está activo
  bool get isActive => status == 'active';
  
  /// Verifica si el préstamo está cerrado
  bool get isClosed => status == 'closed';
  
  /// Verifica si el préstamo está vencido
  bool get isOverdue => status == 'overdue' || 
      (isActive && DateTime.now().isAfter(expectedReturnDate));
  
  /// Calcula los días de retraso (0 si no está vencido)
  int get daysOverdue {
    if (!isOverdue) return 0;
    final now = DateTime.now();
    return now.difference(expectedReturnDate).inDays;
  }
  
  /// Duración total del préstamo en días
  int get totalDays {
    final endDate = actualReturnDate ?? DateTime.now();
    return endDate.difference(startDate).inDays;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Loan && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
  
  @override
  String toString() {
    return 'Loan(id: $id, assetId: $assetId, borrowerId: $borrowerId, status: $status)';
  }
}