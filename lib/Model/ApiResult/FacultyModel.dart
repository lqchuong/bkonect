import 'package:json_annotation/json_annotation.dart';

part 'FacultyModel.g.dart';

@JsonSerializable()
class FacultyModel {
  FacultyModel();
  String id;
  String name;
  factory FacultyModel.fromJson(Map<String, dynamic> json) =>
      _$FacultyModelFromJson(json);
  Map<String, dynamic> toJson() => _$FacultyModelToJson(this);
}
