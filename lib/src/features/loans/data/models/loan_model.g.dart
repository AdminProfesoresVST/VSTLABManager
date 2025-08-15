// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanModel _$LoanModelFromJson(Map<String, dynamic> json) => LoanModel(
      id: json['id'] as String,
      assetId: json['assetId'] as String,
      borrowerId: json['borrowerId'] as String,
      lenderId: json['lenderId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      expectedReturnDate: DateTime.parse(json['expectedReturnDate'] as String),
      actualReturnDate: json['actualReturnDate'] == null
          ? null
          : DateTime.parse(json['actualReturnDate'] as String),
      status: json['status'] as String,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      synced: json['synced'] as bool? ?? false,
      localChanges: json['local_changes'] as bool? ?? false,
    );

Map<String, dynamic> _$LoanModelToJson(LoanModel instance) => <String, dynamic>{
      'id': instance.id,
      'assetId': instance.assetId,
      'borrowerId': instance.borrowerId,
      'lenderId': instance.lenderId,
      'startDate': instance.startDate.toIso8601String(),
      'expectedReturnDate': instance.expectedReturnDate.toIso8601String(),
      'actualReturnDate': instance.actualReturnDate?.toIso8601String(),
      'status': instance.status,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'synced': instance.synced,
      'local_changes': instance.localChanges,
    };
