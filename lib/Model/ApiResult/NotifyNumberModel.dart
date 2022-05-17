import 'package:json_annotation/json_annotation.dart';
part 'NotifyNumberModel.g.dart';

@JsonSerializable()
class NotifyNumberModel {
  NotifyNumberModel();
  int su_kien_tham_gia;
  int su_kien_duoc_moi;
  int tong_su_kien;

  factory NotifyNumberModel.fromJson(Map<String, dynamic> json) =>
      _$NotifyNumberModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotifyNumberModelToJson(this);
}
