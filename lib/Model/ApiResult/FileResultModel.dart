import 'package:json_annotation/json_annotation.dart';
import '../EventFileModel.dart';
part 'FileResultModel.g.dart';

@JsonSerializable()
class FileResultModel {
  FileResultModel();
  EventFileModel db;
  String ten_nguoi_lap;
  String ten_hinh_thuc;
  String ten_nguoi_cap_nhat;
  String ten_cong_ty;

  factory FileResultModel.fromJson(Map<String, dynamic> json) =>
      _$FileResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$FileResultModelToJson(this);
}
