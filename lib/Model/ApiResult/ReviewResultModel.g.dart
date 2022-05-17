// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReviewResultModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewResultModel _$ReviewResultModelFromJson(Map<String, dynamic> json) {
  return ReviewResultModel()
    ..db = json['db'] == null
        ? null
        : ReviewModel.fromJson(json['db'] as Map<String, dynamic>)
    ..user_name = json['user_name'] as String
    ..id_khach_moi = json['id_khach_moi'] as String
    ..id_ban_to_chuc = json['id_ban_to_chuc'] as String
    ..position = json['position'] as String
    ..avatar_link = json['avatar_link'] as String
    ..ten_cong_ty = json['ten_cong_ty'] as String
    ..school_year = json['school_year'] as String
    ..faculty = json['faculty'] as String
    ..role_view = json['role_view'] as int
    ..ten_quoc_gia = json['ten_quoc_gia'] as String
    ..ten_su_kien = json['ten_su_kien'] as String;
}

Map<String, dynamic> _$ReviewResultModelToJson(ReviewResultModel instance) =>
    <String, dynamic>{
      'db': instance.db,
      'user_name': instance.user_name,
      'id_khach_moi': instance.id_khach_moi,
      'id_ban_to_chuc': instance.id_ban_to_chuc,
      'position': instance.position,
      'avatar_link': instance.avatar_link,
      'ten_cong_ty': instance.ten_cong_ty,
      'school_year': instance.school_year,
      'faculty': instance.faculty,
      'role_view': instance.role_view,
      'ten_quoc_gia': instance.ten_quoc_gia,
      'ten_su_kien': instance.ten_su_kien,
    };
