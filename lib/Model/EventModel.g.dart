// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EventModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) {
  return EventModel()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..intro = json['intro'] as String
    ..logo = json['logo'] as String
    ..time_create = json['time_create'] == null
        ? null
        : DateTime.parse(json['time_create'] as String)
    ..time_start = json['time_start'] == null
        ? null
        : DateTime.parse(json['time_start'] as String)
    ..time_end = json['time_end'] == null
        ? null
        : DateTime.parse(json['time_end'] as String)
    ..location = json['location'] as String
    ..mo_ta = json['mo_ta'] as String
    ..max_person_participate = json['max_person_participate'] as int
    ..type = json['type'] as int;
}

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'intro': instance.intro,
      'logo': instance.logo,
      'time_create': instance.time_create?.toIso8601String(),
      'time_start': instance.time_start?.toIso8601String(),
      'time_end': instance.time_end?.toIso8601String(),
      'location': instance.location,
      'mo_ta': instance.mo_ta,
      'max_person_participate': instance.max_person_participate,
      'type': instance.type,
    };
