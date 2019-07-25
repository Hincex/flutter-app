// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Community _$CommunityFromJson(Map<String, dynamic> json) {
  return Community()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..community_name = json['community_name'] as String
    ..description = json['description'] as String
    ..data_name = json['data_name'] as String
    ..img = json['img'] as String;
}

Map<String, dynamic> _$CommunityToJson(Community instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'community_name': instance.community_name,
      'description': instance.description,
      'data_name': instance.data_name,
      'img': instance.img,
    };
