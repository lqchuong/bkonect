import 'package:json_annotation/json_annotation.dart';
part 'ErrorModel.g.dart';

@JsonSerializable()
class ErrorModel {
  ErrorModel();
  String Key;

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorModelFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);
}
