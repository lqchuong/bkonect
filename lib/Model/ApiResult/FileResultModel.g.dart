// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FileResultModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileResultModel _$FileResultModelFromJson(Map<String, dynamic> json) {
  return FileResultModel()
    ..db = json['db'] == null
        ? null
        : EventFileModel.fromJson(json['db'] as Map<String, dynamic>)
    ..ten_nguoi_lap = json['ten_nguoi_lap'] as String
    ..ten_hinh_thuc = json['ten_hinh_thuc'] as String
    ..ten_nguoi_cap_nhat = json['ten_nguoi_cap_nhat'] as String
    ..ten_cong_ty = json['ten_cong_ty'] as String;
}

Map<String, dynamic> _$FileResultModelToJson(FileResultModel instance) =>
    <String, dynamic>{
      'db': instance.db,
      'ten_nguoi_lap': instance.ten_nguoi_lap,
      'ten_hinh_thuc': instance.ten_hinh_thuc,
      'ten_nguoi_cap_nhat': instance.ten_nguoi_cap_nhat,
      'ten_cong_ty': instance.ten_cong_ty,
    };
