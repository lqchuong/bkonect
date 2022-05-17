// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RegisterResultModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResultModel _$RegisterResultModelFromJson(Map<String, dynamic> json) {
  return RegisterResultModel()
    ..db = json['db'] == null
        ? null
        : RegisterReceiveModel.fromJson(json['db'] as Map<String, dynamic>)
    ..createby_name = json['createby_name'] as String
    ..ten_quoc_gia = json['ten_quoc_gia'] as String
    ..ten_cong_ty = json['ten_cong_ty'] as String
    ..ten_khoa = json['ten_khoa'] as String;
}

Map<String, dynamic> _$RegisterResultModelToJson(
        RegisterResultModel instance) =>
    <String, dynamic>{
      'db': instance.db,
      'createby_name': instance.createby_name,
      'ten_quoc_gia': instance.ten_quoc_gia,
      'ten_cong_ty': instance.ten_cong_ty,
      'ten_khoa': instance.ten_khoa,
    };
