import 'package:json_annotation/json_annotation.dart';

part 'CompanyInRegister.g.dart';

@JsonSerializable()
class CompanyInRegister {
  CompanyInRegister();
  String id;
  String name;
  factory CompanyInRegister.fromJson(Map<String, dynamic> json) =>
      _$CompanyInRegisterFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyInRegisterToJson(this);
}
