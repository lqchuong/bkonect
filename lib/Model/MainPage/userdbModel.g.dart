// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userdbModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

userdbModel _$userdbModelFromJson(Map<String, dynamic> json) {
  return userdbModel()
    ..id = json['id'] as String
    ..email = json['email'] as String
    ..phoneNumber = json['phoneNumber'] as String
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..field = json['field'] as String
    ..avatar_link = json['avatar_link'] as String
    ..gm = json['gm'] as int
    ..date_create = json['date_create'] as int;
}

Map<String, dynamic> _$userdbModelToJson(userdbModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'field': instance.field,
      'avatar_link': instance.avatar_link,
      'gm': instance.gm,
      'date_create': instance.date_create,
    };
