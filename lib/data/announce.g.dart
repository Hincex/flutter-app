// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Announce _$AnnounceFromJson(Map<String, dynamic> json) {
  return Announce()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..author = json['author'] as String
    ..title = json['title'] as String
    ..content = json['content'] as String;
}

Map<String, dynamic> _$AnnounceToJson(Announce instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'author': instance.author,
      'title': instance.title,
      'content': instance.content,
    };
