// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChangePassword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePassword _$ChangePasswordFromJson(Map<String, dynamic> json) {
  return ChangePassword()
    ..old_password = json['old_password'] as String
    ..new_password = json['new_password'] as String;
}

Map<String, dynamic> _$ChangePasswordToJson(ChangePassword instance) =>
    <String, dynamic>{
      'old_password': instance.old_password,
      'new_password': instance.new_password,
    };
