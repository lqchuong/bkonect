// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EventParticipateModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventParticipateModel _$EventParticipateModelFromJson(
    Map<String, dynamic> json) {
  return EventParticipateModel()
    ..id = json['id'] as String
    ..user_id = json['user_id'] as String
    ..id_event = json['id_event'] as String
    ..date_add = json['date_add'] == null
        ? null
        : DateTime.parse(json['date_add'] as String)
    ..company_id = json['company_id'] as String
    ..role = json['role'] as int
    ..note = json['note'] as String
    ..review_note = json['review_note'] as String
    ..review_rate = json['review_rate'] as String
    ..check_in_status = json['check_in_status'] as int
    ..check_in_date = json['check_in_date'] == null
        ? null
        : DateTime.parse(json['check_in_date'] as String);
}

Map<String, dynamic> _$EventParticipateModelToJson(
        EventParticipateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'id_event': instance.id_event,
      'date_add': instance.date_add?.toIso8601String(),
      'company_id': instance.company_id,
      'role': instance.role,
      'note': instance.note,
      'review_note': instance.review_note,
      'review_rate': instance.review_rate,
      'check_in_status': instance.check_in_status,
      'check_in_date': instance.check_in_date?.toIso8601String(),
    };
