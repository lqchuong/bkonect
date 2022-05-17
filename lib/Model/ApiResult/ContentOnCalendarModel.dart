import 'package:json_annotation/json_annotation.dart';

import '../EventProgramModel.dart';
part 'ContentOnCalendarModel.g.dart';

@JsonSerializable()
class ContentOnCalendarModel {
  ContentOnCalendarModel();
  //userid+id_building

  EventProgramModel db;
  String ten_su_kien;

  factory ContentOnCalendarModel.fromJson(Map<String, dynamic> json) =>
      _$ContentOnCalendarModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContentOnCalendarModelToJson(this);
}
