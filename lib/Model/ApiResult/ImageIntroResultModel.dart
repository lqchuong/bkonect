import 'package:json_annotation/json_annotation.dart';
import '../ImageIntroModel.dart';
part 'ImageIntroResultModel.g.dart';

@JsonSerializable()
class ImageIntroResultModel {
  ImageIntroResultModel();
  ImageIntroModel db;
  String ten_nguoi_lap;
  String ten_hinh_thuc;
  String ten_nguoi_cap_nhat;
  String ten_cong_ty;

  factory ImageIntroResultModel.fromJson(Map<String, dynamic> json) =>
      _$ImageIntroResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$ImageIntroResultModelToJson(this);
}
