import 'package:json_annotation/json_annotation.dart';

import '../EventQAModel.dart';
part 'EventQaResulModel.g.dart';

@JsonSerializable()
class EventQaResulModel {
  EventQaResulModel();
  //userid+id_building
  String user_answer;
  String user_question;
  String ten_su_kien;

  EventQAModel db;

  factory EventQaResulModel.fromJson(Map<String, dynamic> json) =>
      _$EventQaResulModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventQaResulModelToJson(this);
}
