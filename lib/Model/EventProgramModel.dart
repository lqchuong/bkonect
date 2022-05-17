import 'package:json_annotation/json_annotation.dart';
part 'EventProgramModel.g.dart';

@JsonSerializable()
class EventProgramModel {
  EventProgramModel();

  String id;
  String name;
  String description;
  DateTime start_time;
  DateTime end_time;
  String create_by;
  DateTime create_date;
  String presenter;
  int max_person_participate;
  String event_id;
  String location;
  int stt;

  factory EventProgramModel.fromJson(Map<String, dynamic> json) =>
      _$EventProgramModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventProgramModelToJson(this);
}
