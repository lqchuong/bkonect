// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegisterModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterModel _$RegisterModelFromJson(Map<String, dynamic> json) {
  return RegisterModel()
    ..FirstName = json['FirstName'] as String
    ..LastName = json['LastName'] as String
    ..FullName = json['FullName'] as String
    ..email = json['email'] as String
    ..dienthoai = json['dienthoai'] as String
    ..status = json['status'] as int
    ..note = json['note'] as String
    ..field = json['field'] as String
    ..id_country = json['id_country'] as String
    ..position = json['position'] as String
    ..school_year = json['school_year'] as String
    ..id_faculty = json['id_faculty'] as String
    ..sex = json['sex'] as int
    ..day_of_birth = json['day_of_birth'] == null
        ? null
        : DateTime.parse(json['day_of_birth'] as String)
    ..id_company = json['id_company'] as String
    ..avatar_link = json['avatar_link'] as String;
}

Map<String, dynamic> _$RegisterModelToJson(RegisterModel instance) =>
    <String, dynamic>{
      'FirstName': instance.FirstName,
      'LastName': instance.LastName,
      'FullName': instance.FullName,
      'email': instance.email,
      'dienthoai': instance.dienthoai,
      'status': instance.status,
      'note': instance.note,
      'field': instance.field,
      'id_country': instance.id_country,
      'position': instance.position,
      'school_year': instance.school_year,
      'id_faculty': instance.id_faculty,
      'sex': instance.sex,
      'day_of_birth': instance.day_of_birth?.toIso8601String(),
      'id_company': instance.id_company,
      'avatar_link': instance.avatar_link,
    };
