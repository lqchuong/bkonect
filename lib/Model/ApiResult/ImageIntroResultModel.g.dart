// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ImageIntroResultModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageIntroResultModel _$ImageIntroResultModelFromJson(
    Map<String, dynamic> json) {
  return ImageIntroResultModel()
    ..db = json['db'] == null
        ? null
        : ImageIntroModel.fromJson(json['db'] as Map<String, dynamic>)
    ..ten_nguoi_lap = json['ten_nguoi_lap'] as String
    ..ten_hinh_thuc = json['ten_hinh_thuc'] as String
    ..ten_nguoi_cap_nhat = json['ten_nguoi_cap_nhat'] as String
    ..ten_cong_ty = json['ten_cong_ty'] as String;
}

Map<String, dynamic> _$ImageIntroResultModelToJson(
        ImageIntroResultModel instance) =>
    <String, dynamic>{
      'db': instance.db,
      'ten_nguoi_lap': instance.ten_nguoi_lap,
      'ten_hinh_thuc': instance.ten_hinh_thuc,
      'ten_nguoi_cap_nhat': instance.ten_nguoi_cap_nhat,
      'ten_cong_ty': instance.ten_cong_ty,
    };
