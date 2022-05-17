import 'package:json_annotation/json_annotation.dart';
part 'ReviewModel.g.dart';

@JsonSerializable()
class ReviewModel {
  ReviewModel();
  String id;
  String event_id;
  String user_id;
  DateTime date_add;
  String company_id;

  int role;
  String note;
  String review_note;
  int review_rate;

  int check_in_status;
  DateTime check_in_date;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}
