import 'package:json_annotation/json_annotation.dart';
part 'NotificationModel.g.dart';

@JsonSerializable()
class NotificationModel {
  NotificationModel();
  //userid+id_building
  String id;
  String user_id;
  String title;
  String description;
  String menu;
  String param;
  DateTime date_send;
  String logo;
  int status_read; // 1- Chưa đọc, 2- đã đọc
  String contenthtml;
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
