import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'TokenNotiUserModel.g.dart';

@JsonSerializable()
class TokenNotiUserModel {
  TokenNotiUserModel();
  //userid+id_building
  String id;
  String user_id;
  String token_firebase;
  DateTime create_date;
  int count_notification;
  int count_today_metting;
  DateTime date_upDate;
  int count_waranty_processing;
  int count_repair_processing;
  int unread_notification;
  int unread_waranty_receive;
  int unread_repair_receive;

  factory TokenNotiUserModel.fromJson(Map<String, dynamic> json) =>
      _$TokenNotiUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$TokenNotiUserModelToJson(this);
}
