import 'package:json_annotation/json_annotation.dart';
part 'userdbModel.g.dart';

@JsonSerializable()
class userdbModel {
  userdbModel();
  //userid+id_building
  String id;
  String email;
  String phoneNumber;
  String firstName;
  String lastName;
  String field; // lĩnh vực
  String avatar_link;
  int gm; // 1-24 múi giờ
  int date_create;

  factory userdbModel.fromJson(Map<String, dynamic> json) =>
      _$userdbModelFromJson(json);
  Map<String, dynamic> toJson() => _$userdbModelToJson(this);
}
