// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TokenNotiUserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenNotiUserModel _$TokenNotiUserModelFromJson(Map<String, dynamic> json) {
  return TokenNotiUserModel()
    ..id = json['id'] as String
    ..user_id = json['user_id'] as String
    ..token_firebase = json['token_firebase'] as String
    ..create_date = json['create_date'] == null
        ? null
        : DateTime.parse(json['create_date'] as String)
    ..count_notification = json['count_notification'] as int
    ..count_today_metting = json['count_today_metting'] as int
    ..date_upDate = json['date_upDate'] == null
        ? null
        : DateTime.parse(json['date_upDate'] as String)
    ..count_waranty_processing = json['count_waranty_processing'] as int
    ..count_repair_processing = json['count_repair_processing'] as int
    ..unread_notification = json['unread_notification'] as int
    ..unread_waranty_receive = json['unread_waranty_receive'] as int
    ..unread_repair_receive = json['unread_repair_receive'] as int;
}

Map<String, dynamic> _$TokenNotiUserModelToJson(TokenNotiUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'token_firebase': instance.token_firebase,
      'create_date': instance.create_date?.toIso8601String(),
      'count_notification': instance.count_notification,
      'count_today_metting': instance.count_today_metting,
      'date_upDate': instance.date_upDate?.toIso8601String(),
      'count_waranty_processing': instance.count_waranty_processing,
      'count_repair_processing': instance.count_repair_processing,
      'unread_notification': instance.unread_notification,
      'unread_waranty_receive': instance.unread_waranty_receive,
      'unread_repair_receive': instance.unread_repair_receive,
    };
