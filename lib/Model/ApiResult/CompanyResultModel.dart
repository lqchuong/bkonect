import 'package:json_annotation/json_annotation.dart';

import '../CompanyModel.dart';

part 'CompanyResultModel.g.dart';

@JsonSerializable()
class CompanyResultModel {
  CompanyResultModel();
  CompanyModel db;
  factory CompanyResultModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyResultModelToJson(this);
}
