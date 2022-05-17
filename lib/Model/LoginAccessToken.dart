import 'package:json_annotation/json_annotation.dart';
part 'LoginAccessToken.g.dart';

@JsonSerializable()
class LoginAccessToken {
  LoginAccessToken();
  String id;
  String username;
  String firstName;
  String lastName;
  String fullName;
  String token;
  factory LoginAccessToken.fromJson(Map<String, dynamic> json) =>
      _$LoginAccessTokenFromJson(json);
  Map<String, dynamic> toJson() => _$LoginAccessTokenToJson(this);
}
