import 'package:json_annotation/json_annotation.dart';
part 'SubEventParticipateModel.g.dart';

@JsonSerializable()
class SubEventParticipateModel {
  SubEventParticipateModel();
  //userid+id_building
  String id;
  String name;
  int time_start;
  int time_end;
  String company_id;
  String intro;
  String location;
  String event_id;
  int max_person_participate;

  factory SubEventParticipateModel.fromJson(Map<String, dynamic> json) =>
      _$SubEventParticipateModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubEventParticipateModelToJson(this);
}
