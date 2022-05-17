// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EventQAModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventQAModel _$EventQAModelFromJson(Map<String, dynamic> json) {
  return EventQAModel()
    ..id = json['id'] as String
    ..event_id = json['event_id'] as String
    ..question = json['question'] as String
    ..answer = json['answer'] as String
    ..time_question = json['time_question'] == null
        ? null
        : DateTime.parse(json['time_question'] as String)
    ..time_answer = json['time_answer'] == null
        ? null
        : DateTime.parse(json['time_answer'] as String)
    ..user_id_question = json['user_id_question'] as String
    ..user_id_answer = json['user_id_answer'] as String;
}

Map<String, dynamic> _$EventQAModelToJson(EventQAModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.event_id,
      'question': instance.question,
      'answer': instance.answer,
      'time_question': instance.time_question?.toIso8601String(),
      'time_answer': instance.time_answer?.toIso8601String(),
      'user_id_question': instance.user_id_question,
      'user_id_answer': instance.user_id_answer,
    };
