// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EventFileModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventFileModel _$EventFileModelFromJson(Map<String, dynamic> json) {
  return EventFileModel()
    ..id = json['id'] as String
    ..event_id = json['event_id'] as String
    ..file_name = json['file_name'] as String
    ..file_path = json['file_path'] as String
    ..extension = json['extension'] as String
    ..date_update = json['date_update'] as String
    ..upload_by_userid = json['upload_by_userid'] as String
    ..size = json['size'] as int
    ..create_date = json['create_date'] == null
        ? null
        : DateTime.parse(json['create_date'] as String);
}

Map<String, dynamic> _$EventFileModelToJson(EventFileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.event_id,
      'file_name': instance.file_name,
      'file_path': instance.file_path,
      'extension': instance.extension,
      'date_update': instance.date_update,
      'upload_by_userid': instance.upload_by_userid,
      'size': instance.size,
      'create_date': instance.create_date?.toIso8601String(),
    };
