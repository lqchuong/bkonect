import 'package:json_annotation/json_annotation.dart';
part 'RegisterReceiveModel.g.dart';

@JsonSerializable()
class RegisterReceiveModel {
  RegisterReceiveModel();
  String id;
  String firstName;
  String lastName;
  String fullName;
  String username;

  String id_chuc_danh;
  String id_phong_ban;
  String passwordHash;
  String passwordSalt;
  String email;

  String dienthoai;
  int status;
  String note;
  int id_increase;
  String avatar_link;

  String field;
  String id_country;
  String position;
  String school_year;
  String id_faculty;

  int sex; // 1- Nam, 2- Nữ
  DateTime day_of_birth;
  String id_company;

  factory RegisterReceiveModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterReceiveModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterReceiveModelToJson(this);
}
