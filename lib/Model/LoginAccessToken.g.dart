// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginAccessToken.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginAccessToken _$LoginAccessTokenFromJson(Map<String, dynamic> json) {
  return LoginAccessToken()
    ..id = json['id'] as String
    ..username = json['username'] as String
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..fullName = json['fullName'] as String
    ..token = json['token'] as String;
}

Map<String, dynamic> _$LoginAccessTokenToJson(LoginAccessToken instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'fullName': instance.fullName,
      'token': instance.token,
    };
