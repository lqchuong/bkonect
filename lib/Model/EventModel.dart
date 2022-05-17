import 'package:json_annotation/json_annotation.dart';
part 'EventModel.g.dart';

@JsonSerializable()
class EventModel {
  EventModel();
  //userid+id_building
  String id;
  String title;
  String intro;
  String logo;
  DateTime time_create;
  DateTime time_start;
  DateTime time_end;
  String location;
  String mo_ta;
  int max_person_participate;
  // String link_su_kien;
  int type; // 1- offline, 2- online. default value = 1

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
