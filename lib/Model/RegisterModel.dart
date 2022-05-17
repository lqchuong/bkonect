import 'package:json_annotation/json_annotation.dart';
part 'RegisterModel.g.dart';

@JsonSerializable()
class RegisterModel {
  RegisterModel();
  String FirstName;

  String LastName;
  String FullName;
  String email;
  String dienthoai;
  int status;

  String note;
  String field;
  String id_country;
  String position;
  String school_year;

  String id_faculty;
  int sex; // 1- Nam, 2- Nữ
  DateTime day_of_birth;
  String id_company;
  String avatar_link;
  factory RegisterModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterModelToJson(this);
}
