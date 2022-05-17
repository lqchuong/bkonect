import 'package:json_annotation/json_annotation.dart';
part 'EventFileModel.g.dart';

@JsonSerializable()
class EventFileModel {
  EventFileModel();
  //userid+id_building
  String id;
  String event_id;
  String file_name;
  String file_path;
  String extension;
  String date_update;
  String upload_by_userid;
  int size; // to byte
  DateTime create_date;

  factory EventFileModel.fromJson(Map<String, dynamic> json) =>
      _$EventFileModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventFileModelToJson(this);
}
