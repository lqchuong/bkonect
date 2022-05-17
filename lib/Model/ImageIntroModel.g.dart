// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ImageIntroModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageIntroModel _$ImageIntroModelFromJson(Map<String, dynamic> json) {
  return ImageIntroModel()
    ..id = json['id'] as String
    ..event_id = json['event_id'] as String
    ..file_name = json['file_name'] as String
    ..file_path = json['file_path'] as String
    ..upload_by_userid = json['upload_by_userid'] as String
    ..create_date = json['create_date'] == null
        ? null
        : DateTime.parse(json['create_date'] as String)
    ..size = json['size'] as int
    ..note = json['note'] as String;
}

Map<String, dynamic> _$ImageIntroModelToJson(ImageIntroModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.event_id,
      'file_name': instance.file_name,
      'file_path': instance.file_path,
      'upload_by_userid': instance.upload_by_userid,
      'create_date': instance.create_date?.toIso8601String(),
      'size': instance.size,
      'note': instance.note,
    };
