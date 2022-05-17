import 'package:json_annotation/json_annotation.dart';
import 'package:worldsoft_maintain/Model/EventModel.dart';
part 'EventResultModel.g.dart';

@JsonSerializable()
class EventResultModel {
  EventResultModel();
  //userid+id_building
  String ten_nguoi_lap;
  String ten_hinh_thuc;
  String ten_nguoi_cap_nhat;
  String ten_cong_ty;
  int check_in_status;
  int trang_thai;
  EventModel db;

  factory EventResultModel.fromJson(Map<String, dynamic> json) =>
      _$EventResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventResultModelToJson(this);
}
