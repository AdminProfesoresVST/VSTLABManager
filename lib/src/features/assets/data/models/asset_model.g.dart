// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetModel _$AssetModelFromJson(Map<String, dynamic> json) => AssetModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      value: (json['value'] as num).toDouble(),
      status: json['status'] as String,
      branchId: json['branchId'] as String,
      qrCode: json['qrCode'] as String,
      imageUrl: json['imageUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      synced: json['synced'] as bool? ?? false,
      localChanges: json['local_changes'] as bool? ?? false,
    );

Map<String, dynamic> _$AssetModelToJson(AssetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'value': instance.value,
      'status': instance.status,
      'branchId': instance.branchId,
      'qrCode': instance.qrCode,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'synced': instance.synced,
      'local_changes': instance.localChanges,
    };
