// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Advice _$AdviceFromJson(Map<String, dynamic> json) {
  return Advice()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..user = json['user'] as String
    ..content = json['content'] as String;
}

Map<String, dynamic> _$AdviceToJson(Advice instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'user': instance.user,
      'content': instance.content,
    };
