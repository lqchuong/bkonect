import 'package:json_annotation/json_annotation.dart';
part 'ProductErrorModel.g.dart';

@JsonSerializable()
class ProductErrorModel {
  ProductErrorModel();
  String id;
  String id_product;
  String product_name;
  String id_product_type;
  String name_product_type;
  String unit_name;
  String error_name;
  String total_price;
  String note;

  factory ProductErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ProductErrorModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductErrorModelToJson(this);
}
