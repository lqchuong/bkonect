import 'package:json_annotation/json_annotation.dart';
part 'CompanyModel.g.dart';

@JsonSerializable()
class CompanyModel {
  CompanyModel();
  //userid+id_building
  String id;
  String tax_code;
  String name;
  String short_name;
  String description;
  String field;
  String logo_link;
  String id_country;
  String country_name;
  String location;
  DateTime create_date;

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);
}
