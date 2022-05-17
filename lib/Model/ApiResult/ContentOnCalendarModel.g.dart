// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ContentOnCalendarModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentOnCalendarModel _$ContentOnCalendarModelFromJson(
    Map<String, dynamic> json) {
  return ContentOnCalendarModel()
    ..db = json['db'] == null
        ? null
        : EventProgramModel.fromJson(json['db'] as Map<String, dynamic>)
    ..ten_su_kien = json['ten_su_kien'] as String;
}

Map<String, dynamic> _$ContentOnCalendarModelToJson(
        ContentOnCalendarModel instance) =>
    <String, dynamic>{
      'db': instance.db,
      'ten_su_kien': instance.ten_su_kien,
    };
