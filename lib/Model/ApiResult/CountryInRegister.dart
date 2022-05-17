import 'package:json_annotation/json_annotation.dart';

part 'CountryInRegister.g.dart';

@JsonSerializable()
class CountryInRegister {
  CountryInRegister();
  String id;
  String name;
  factory CountryInRegister.fromJson(Map<String, dynamic> json) =>
      _$CountryInRegisterFromJson(json);
  Map<String, dynamic> toJson() => _$CountryInRegisterToJson(this);
}
