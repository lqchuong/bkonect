// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubEventParticipateModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubEventParticipateModel _$SubEventParticipateModelFromJson(
    Map<String, dynamic> json) {
  return SubEventParticipateModel()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..time_start = json['time_start'] as int
    ..time_end = json['time_end'] as int
    ..company_id = json['company_id'] as String
    ..intro = json['intro'] as String
    ..location = json['location'] as String
    ..event_id = json['event_id'] as String
    ..max_person_participate = json['max_person_participate'] as int;
}

Map<String, dynamic> _$SubEventParticipateModelToJson(
        SubEventParticipateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'time_start': instance.time_start,
      'time_end': instance.time_end,
      'company_id': instance.company_id,
      'intro': instance.intro,
      'location': instance.location,
      'event_id': instance.event_id,
      'max_person_participate': instance.max_person_participate,
    };
