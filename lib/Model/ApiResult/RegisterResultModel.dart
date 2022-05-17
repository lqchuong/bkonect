import 'package:json_annotation/json_annotation.dart';
import 'package:worldsoft_maintain/Model/RegisterModel.dart';
import 'package:worldsoft_maintain/Model/RegisterReceiveModel.dart';
part 'RegisterResultModel.g.dart';

@JsonSerializable()
class RegisterResultModel {
  RegisterResultModel();
  RegisterReceiveModel db;
  String createby_name;
  String ten_quoc_gia;
  String ten_cong_ty;
  String ten_khoa;

  factory RegisterResultModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResultModelToJson(this);
}
