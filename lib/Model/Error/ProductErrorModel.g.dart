// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductErrorModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductErrorModel _$ProductErrorModelFromJson(Map<String, dynamic> json) {
  return ProductErrorModel()
    ..id = json['id'] as String
    ..id_product = json['id_product'] as String
    ..product_name = json['product_name'] as String
    ..id_product_type = json['id_product_type'] as String
    ..name_product_type = json['name_product_type'] as String
    ..unit_name = json['unit_name'] as String
    ..error_name = json['error_name'] as String
    ..total_price = json['total_price'] as String
    ..note = json['note'] as String;
}

Map<String, dynamic> _$ProductErrorModelToJson(ProductErrorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_product': instance.id_product,
      'product_name': instance.product_name,
      'id_product_type': instance.id_product_type,
      'name_product_type': instance.name_product_type,
      'unit_name': instance.unit_name,
      'error_name': instance.error_name,
      'total_price': instance.total_price,
      'note': instance.note,
    };
