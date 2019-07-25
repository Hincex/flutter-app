// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map<String, dynamic> json) {
  return Content()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..title = json['title'] as String
    ..content = json['content'] as String
    ..type = json['type'] as String
    ..img = json['img'] as String;

}

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'title': instance.title,
      'content': instance.content,
      'type': instance.type,
      'img': instance.img,
    };
