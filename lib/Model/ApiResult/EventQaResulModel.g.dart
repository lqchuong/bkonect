// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EventQaResulModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventQaResulModel _$EventQaResulModelFromJson(Map<String, dynamic> json) {
  return EventQaResulModel()
    ..user_answer = json['user_answer'] as String
    ..user_question = json['user_question'] as String
    ..ten_su_kien = json['ten_su_kien'] as String
    ..db = json['db'] == null
        ? null
        : EventQAModel.fromJson(json['db'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EventQaResulModelToJson(EventQaResulModel instance) =>
    <String, dynamic>{
      'user_answer': instance.user_answer,
      'user_question': instance.user_question,
      'ten_su_kien': instance.ten_su_kien,
      'db': instance.db,
    };
