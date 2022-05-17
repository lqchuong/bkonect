import 'package:json_annotation/json_annotation.dart';
part 'ImageIntroModel.g.dart';

@JsonSerializable()
class ImageIntroModel {
  ImageIntroModel();
  //userid+id_building
  String id;
  String event_id;
  String file_name;
  String file_path;
  String upload_by_userid;
  DateTime create_date;
  int size;
  String note;

  factory ImageIntroModel.fromJson(Map<String, dynamic> json) =>
      _$ImageIntroModelFromJson(json);
  Map<String, dynamic> toJson() => _$ImageIntroModelToJson(this);
}
