// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserCompanyModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCompanyModel _$UserCompanyModelFromJson(Map<String, dynamic> json) {
  return UserCompanyModel()
    ..user_id = json['user_id'] as String
    ..company_id = json['company_id'] as String
    ..company_name = json['company_name'] as String
    ..name = json['name'] as String
    ..avatar = json['avatar'] as String
    ..role = json['role'] as String
    ..date_add = json['date_add'] as int
    ..intro = json['intro'] as String
    ..position = json['position'] as String
    ..department = json['department'] as String
    ..show_intro = json['show_intro'] as int;
}

Map<String, dynamic> _$UserCompanyModelToJson(UserCompanyModel instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'company_id': instance.company_id,
      'company_name': instance.company_name,
      'name': instance.name,
      'avatar': instance.avatar,
      'role': instance.role,
      'date_add': instance.date_add,
      'intro': instance.intro,
      'position': instance.position,
      'department': instance.department,
      'show_intro': instance.show_intro,
    };
