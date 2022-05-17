// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EventResultModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventResultModel _$EventResultModelFromJson(Map<String, dynamic> json) {
  return EventResultModel()
    ..ten_nguoi_lap = json['ten_nguoi_lap'] as String
    ..ten_hinh_thuc = json['ten_hinh_thuc'] as String
    ..ten_nguoi_cap_nhat = json['ten_nguoi_cap_nhat'] as String
    ..ten_cong_ty = json['ten_cong_ty'] as String
    ..check_in_status = json['check_in_status'] as int
    ..trang_thai = json['trang_thai'] as int
    ..db = json['db'] == null
        ? null
        : EventModel.fromJson(json['db'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EventResultModelToJson(EventResultModel instance) =>
    <String, dynamic>{
      'ten_nguoi_lap': instance.ten_nguoi_lap,
      'ten_hinh_thuc': instance.ten_hinh_thuc,
      'ten_nguoi_cap_nhat': instance.ten_nguoi_cap_nhat,
      'ten_cong_ty': instance.ten_cong_ty,
      'check_in_status': instance.check_in_status,
      'trang_thai': instance.trang_thai,
      'db': instance.db,
    };
