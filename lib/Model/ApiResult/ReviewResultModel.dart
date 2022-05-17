import 'package:json_annotation/json_annotation.dart';
import 'package:worldsoft_maintain/Model/ReviewModel.dart';
part 'ReviewResultModel.g.dart';

@JsonSerializable()
class ReviewResultModel {
  ReviewResultModel();
  ReviewModel db;
  String user_name;
  String id_khach_moi;
  String id_ban_to_chuc;
  String position;
  String avatar_link;
  String ten_cong_ty;
  String school_year;
  String faculty;
  int role_view;
  String ten_quoc_gia;
  String ten_su_kien;

  factory ReviewResultModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewResultModelToJson(this);
}
