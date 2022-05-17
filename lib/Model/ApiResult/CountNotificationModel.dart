import 'package:json_annotation/json_annotation.dart';
part 'CountNotificationModel.g.dart';

@JsonSerializable()
class CountNotificationModel {
  CountNotificationModel();
  int tong_thong_bao;

  factory CountNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$CountNotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountNotificationModelToJson(this);
}
