// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductErrorAccessoriesModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductErrorAccessoriesModel _$ProductErrorAccessoriesModelFromJson(
    Map<String, dynamic> json) {
  return ProductErrorAccessoriesModel()
    ..id = json['id'] as String
    ..id_product_error = json['id_product_error'] as String
    ..accessories_name = json['accessories_name'] as String
    ..accessories_unit = json['accessories_unit'] as String
    ..quantity = json['quantity'] as int
    ..unit_price = json['unit_price'] as String
    ..total_price = json['total_price'] as String
    ..note = json['note'] as String;
}

Map<String, dynamic> _$ProductErrorAccessoriesModelToJson(
        ProductErrorAccessoriesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_product_error': instance.id_product_error,
      'accessories_name': instance.accessories_name,
      'accessories_unit': instance.accessories_unit,
      'quantity': instance.quantity,
      'unit_price': instance.unit_price,
      'total_price': instance.total_price,
      'note': instance.note,
    };
