import 'package:json_annotation/json_annotation.dart';
import 'package:worldsoft_maintain/Model/EventParticipateModel.dart';
part 'EventParticipateResultModel.g.dart';

@JsonSerializable()
class EventParticipateResultModel {
  EventParticipateResultModel();
  //userid+id_building
  String avatar_link;
  String user_name;
  String ten_cong_ty;
  String school_year;
  String faculty;
  String id_khach_moi;
  String id_ban_to_chuc;
  String position;
  String email;
  String dienthoai;
  EventParticipateModel db;

  factory EventParticipateResultModel.fromJson(Map<String, dynamic> json) =>
      _$EventParticipateResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventParticipateResultModelToJson(this);
}
