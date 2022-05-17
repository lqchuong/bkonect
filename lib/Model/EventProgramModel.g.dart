// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EventProgramModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventProgramModel _$EventProgramModelFromJson(Map<String, dynamic> json) {
  return EventProgramModel()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..description = json['description'] as String
    ..start_time = json['start_time'] == null
        ? null
        : DateTime.parse(json['start_time'] as String)
    ..end_time = json['end_time'] == null
        ? null
        : DateTime.parse(json['end_time'] as String)
    ..create_by = json['create_by'] as String
    ..create_date = json['create_date'] == null
        ? null
        : DateTime.parse(json['create_date'] as String)
    ..presenter = json['presenter'] as String
    ..max_person_participate = json['max_person_participate'] as int
    ..event_id = json['event_id'] as String
    ..location = json['location'] as String
    ..stt = json['stt'] as int;
}

Map<String, dynamic> _$EventProgramModelToJson(EventProgramModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'start_time': instance.start_time?.toIso8601String(),
      'end_time': instance.end_time?.toIso8601String(),
      'create_by': instance.create_by,
      'create_date': instance.create_date?.toIso8601String(),
      'presenter': instance.presenter,
      'max_person_participate': instance.max_person_participate,
      'event_id': instance.event_id,
      'location': instance.location,
      'stt': instance.stt,
    };
