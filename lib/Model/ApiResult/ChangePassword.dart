import 'package:json_annotation/json_annotation.dart';

part 'ChangePassword.g.dart';

@JsonSerializable()
class ChangePassword {
  ChangePassword();
  String old_password;
  String new_password;
  factory ChangePassword.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordFromJson(json);
  Map<String, dynamic> toJson() => _$ChangePasswordToJson(this);
}
