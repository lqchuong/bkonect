import 'package:json_annotation/json_annotation.dart';
part 'UserCompanyModel.g.dart';

@JsonSerializable()
class UserCompanyModel {
  UserCompanyModel();
  //userid+id_building
  String user_id;
  String company_id;
  // test 
  String company_name;
  String name;
  String avatar;
  // test 
  String role; // 1- full quyền
  int date_add;
  String intro;
  String position;
  String department;
  int show_intro; // 1- hiển thị lúc xem thông tin công ty

  factory UserCompanyModel.fromJson(Map<String, dynamic> json) =>
      _$UserCompanyModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserCompanyModelToJson(this);
}
