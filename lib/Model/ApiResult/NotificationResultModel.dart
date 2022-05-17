import 'package:json_annotation/json_annotation.dart';
import 'package:worldsoft_maintain/Model/MainPage/NotificationModel.dart';
part 'NotificationResultModel.g.dart';

@JsonSerializable()
class NotificationResultModel {
  NotificationResultModel();
  NotificationModel db;

  factory NotificationResultModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationResultModelToJson(this);
}
