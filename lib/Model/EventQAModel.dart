import 'package:json_annotation/json_annotation.dart';
part 'EventQAModel.g.dart';

@JsonSerializable()
class EventQAModel {
  EventQAModel();
  //userid+id_building
  String id;
  String event_id;
  String question;
  String answer;
  DateTime time_question;
  DateTime time_answer;
  String user_id_question;
  String user_id_answer;

  factory EventQAModel.fromJson(Map<String, dynamic> json) =>
      _$EventQAModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventQAModelToJson(this);
}
