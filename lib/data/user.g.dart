// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..username = json['username'] as String
    ..password = json['password'] as String
    ..email = json['email'] as String
    ..emailVerified = json['emailVerified'] as bool
    ..mobilePhoneNumber = json['mobilePhoneNumber'] as String
    ..mobilePhoneNumberVerified = json['mobilePhoneNumberVerified'] as bool
    ..sessionToken = json['sessionToken'] as String
    ..age = json['age'] as int
    ..gender = json['gender'] as int
    ..nickname = json['nickname'] as String
    ..school = json['school'] as String
    ..job = json['job'] as String
    ..confirm = json['confirm'] as bool;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'mobilePhoneNumber': instance.mobilePhoneNumber,
      'mobilePhoneNumberVerified': instance.mobilePhoneNumberVerified,
      'sessionToken': instance.sessionToken,
      'age': instance.age,
      'gender': instance.gender,
      'nickname': instance.nickname,
      'school': instance.school,
      'job': instance.job,
      'confirm': instance.confirm,
    };
