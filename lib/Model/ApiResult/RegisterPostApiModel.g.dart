// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegisterPostApiModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterPostApiModel _$RegisterPostApiModelFromJson(Map<String, dynamic> json) {
  return RegisterPostApiModel()
    ..db = json['db'] == null
        ? null
        : RegisterModel.fromJson(json['db'] as Map<String, dynamic>)
    ..ten_cong_ty = json['ten_cong_ty'] as String
    ..ten_khoa = json['ten_khoa'] as String
    ..password = json['password'] as String
    ..ten_quoc_gia = json['ten_quoc_gia'] as String;
}

Map<String, dynamic> _$RegisterPostApiModelToJson(
        RegisterPostApiModel instance) =>
    <String, dynamic>{
      'db': instance.db,
      'ten_cong_ty': instance.ten_cong_ty,
      'ten_khoa': instance.ten_khoa,
      'password': instance.password,
      'ten_quoc_gia': instance.ten_quoc_gia,
    };
