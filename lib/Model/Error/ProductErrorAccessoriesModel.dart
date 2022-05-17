import 'package:json_annotation/json_annotation.dart';
part 'ProductErrorAccessoriesModel.g.dart';

@JsonSerializable()
class ProductErrorAccessoriesModel {
  ProductErrorAccessoriesModel();
  String id;
  String id_product_error;
  String accessories_name;
  String accessories_unit;
  int quantity;
  String unit_price;
  String total_price;
  String note;

  factory ProductErrorAccessoriesModel.fromJson(Map<String, dynamic> json) =>
      _$ProductErrorAccessoriesModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductErrorAccessoriesModelToJson(this);
}
