import 'package:json_annotation/json_annotation.dart';
part 'EventParticipateModel.g.dart';

@JsonSerializable()
class EventParticipateModel {
  EventParticipateModel();
  //userid+id_building
  String id;
  String user_id;
  String id_event;
  DateTime date_add;
  String company_id;
  int role; // 1- khách mời, 2- ban tổ chức
  String note;
  String review_note;
  String review_rate;
  int check_in_status;
  DateTime check_in_date;

  factory EventParticipateModel.fromJson(Map<String, dynamic> json) =>
      _$EventParticipateModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventParticipateModelToJson(this);
}
