// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Confirm _$ConfirmFromJson(Map<String, dynamic> json) {
  return Confirm()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..confirmCode = json['confirmCode'] as String
    ..used = json['used'] as bool;
}

Map<String, dynamic> _$ConfirmToJson(Confirm instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'confirmCode': instance.confirmCode,
      'used': instance.used,
    };
