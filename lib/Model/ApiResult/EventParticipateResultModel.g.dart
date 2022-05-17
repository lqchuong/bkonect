// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EventParticipateResultModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventParticipateResultModel _$EventParticipateResultModelFromJson(
    Map<String, dynamic> json) {
  return EventParticipateResultModel()
    ..avatar_link = json['avatar_link'] as String
    ..user_name = json['user_name'] as String
    ..ten_cong_ty = json['ten_cong_ty'] as String
    ..school_year = json['school_year'] as String
    ..faculty = json['faculty'] as String
    ..id_khach_moi = json['id_khach_moi'] as String
    ..id_ban_to_chuc = json['id_ban_to_chuc'] as String
    ..position = json['position'] as String
    ..email = json['email'] as String
    ..dienthoai = json['dienthoai'] as String
    ..db = json['db'] == null
        ? null
        : EventParticipateModel.fromJson(json['db'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EventParticipateResultModelToJson(
        EventParticipateResultModel instance) =>
    <String, dynamic>{
      'avatar_link': instance.avatar_link,
      'user_name': instance.user_name,
      'ten_cong_ty': instance.ten_cong_ty,
      'school_year': instance.school_year,
      'faculty': instance.faculty,
      'id_khach_moi': instance.id_khach_moi,
      'id_ban_to_chuc': instance.id_ban_to_chuc,
      'position': instance.position,
      'email': instance.email,
      'dienthoai': instance.dienthoai,
      'db': instance.db,
    };
