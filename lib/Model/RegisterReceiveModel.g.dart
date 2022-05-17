// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegisterReceiveModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterReceiveModel _$RegisterReceiveModelFromJson(Map<String, dynamic> json) {
  return RegisterReceiveModel()
    ..id = json['id'] as String
    ..firstName = json['firstName'] as String
    ..lastName = json['lastName'] as String
    ..fullName = json['fullName'] as String
    ..username = json['username'] as String
    ..id_chuc_danh = json['id_chuc_danh'] as String
    ..id_phong_ban = json['id_phong_ban'] as String
    ..passwordHash = json['passwordHash'] as String
    ..passwordSalt = json['passwordSalt'] as String
    ..email = json['email'] as String
    ..dienthoai = json['dienthoai'] as String
    ..status = json['status'] as int
    ..note = json['note'] as String
    ..id_increase = json['id_increase'] as int
    ..avatar_link = json['avatar_link'] as String
    ..field = json['field'] as String
    ..id_country = json['id_country'] as String
    ..position = json['position'] as String
    ..school_year = json['school_year'] as String
    ..id_faculty = json['id_faculty'] as String
    ..sex = json['sex'] as int
    ..day_of_birth = json['day_of_birth'] == null
        ? null
        : DateTime.parse(json['day_of_birth'] as String)
    ..id_company = json['id_company'] as String;
}

Map<String, dynamic> _$RegisterReceiveModelToJson(
        RegisterReceiveModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'fullName': instance.fullName,
      'username': instance.username,
      'id_chuc_danh': instance.id_chuc_danh,
      'id_phong_ban': instance.id_phong_ban,
      'passwordHash': instance.passwordHash,
      'passwordSalt': instance.passwordSalt,
      'email': instance.email,
      'dienthoai': instance.dienthoai,
      'status': instance.status,
      'note': instance.note,
      'id_increase': instance.id_increase,
      'avatar_link': instance.avatar_link,
      'field': instance.field,
      'id_country': instance.id_country,
      'position': instance.position,
      'school_year': instance.school_year,
      'id_faculty': instance.id_faculty,
      'sex': instance.sex,
      'day_of_birth': instance.day_of_birth?.toIso8601String(),
      'id_company': instance.id_company,
    };
