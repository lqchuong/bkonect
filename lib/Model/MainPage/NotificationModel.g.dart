// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return NotificationModel()
    ..id = json['id'] as String
    ..user_id = json['user_id'] as String
    ..title = json['title'] as String
    ..description = json['description'] as String
    ..menu = json['menu'] as String
    ..param = json['param'] as String
    ..date_send = json['date_send'] == null
        ? null
        : DateTime.parse(json['date_send'] as String)
    ..logo = json['logo'] as String
    ..status_read = json['status_read'] as int
    ..contenthtml = json['contenthtml'] as String;
}

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'title': instance.title,
      'description': instance.description,
      'menu': instance.menu,
      'param': instance.param,
      'date_send': instance.date_send?.toIso8601String(),
      'logo': instance.logo,
      'status_read': instance.status_read,
      'contenthtml': instance.contenthtml,
    };
