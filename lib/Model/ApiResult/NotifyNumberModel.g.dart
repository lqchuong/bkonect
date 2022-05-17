// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotifyNumberModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotifyNumberModel _$NotifyNumberModelFromJson(Map<String, dynamic> json) {
  return NotifyNumberModel()
    ..su_kien_tham_gia = json['su_kien_tham_gia'] as int
    ..su_kien_duoc_moi = json['su_kien_duoc_moi'] as int
    ..tong_su_kien = json['tong_su_kien'] as int;
}

Map<String, dynamic> _$NotifyNumberModelToJson(NotifyNumberModel instance) =>
    <String, dynamic>{
      'su_kien_tham_gia': instance.su_kien_tham_gia,
      'su_kien_duoc_moi': instance.su_kien_duoc_moi,
      'tong_su_kien': instance.tong_su_kien,
    };
