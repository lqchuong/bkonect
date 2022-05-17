import 'package:json_annotation/json_annotation.dart';

import '../EventProgramModel.dart';
part 'ContentResultModel.g.dart';

@JsonSerializable()
class ContentResultModel {
  ContentResultModel();
  //userid+id_building

  EventProgramModel db;

  factory ContentResultModel.fromJson(Map<String, dynamic> json) =>
      _$ContentResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContentResultModelToJson(this);
}
