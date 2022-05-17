// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NotificationResultModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResultModel _$NotificationResultModelFromJson(
    Map<String, dynamic> json) {
  return NotificationResultModel()
    ..db = json['db'] == null
        ? null
        : NotificationModel.fromJson(json['db'] as Map<String, dynamic>);
}

Map<String, dynamic> _$NotificationResultModelToJson(
        NotificationResultModel instance) =>
    <String, dynamic>{
      'db': instance.db,
    };
