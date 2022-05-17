import 'package:json_annotation/json_annotation.dart';
import 'package:worldsoft_maintain/Model/RegisterModel.dart';
part 'RegisterPostApiModel.g.dart';

@JsonSerializable()
class RegisterPostApiModel {
  RegisterPostApiModel();
  RegisterModel db;
  String ten_cong_ty;
  String ten_khoa;
  String password;
  String ten_quoc_gia;

  factory RegisterPostApiModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterPostApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterPostApiModelToJson(this);
}
