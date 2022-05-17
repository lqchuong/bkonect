// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CompanyModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) {
  return CompanyModel()
    ..id = json['id'] as String
    ..tax_code = json['tax_code'] as String
    ..name = json['name'] as String
    ..short_name = json['short_name'] as String
    ..description = json['description'] as String
    ..field = json['field'] as String
    ..logo_link = json['logo_link'] as String
    ..id_country = json['id_country'] as String
    ..country_name = json['country_name'] as String
    ..location = json['location'] as String
    ..create_date = json['create_date'] == null
        ? null
        : DateTime.parse(json['create_date'] as String);
}

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tax_code': instance.tax_code,
      'name': instance.name,
      'short_name': instance.short_name,
      'description': instance.description,
      'field': instance.field,
      'logo_link': instance.logo_link,
      'id_country': instance.id_country,
      'country_name': instance.country_name,
      'location': instance.location,
      'create_date': instance.create_date?.toIso8601String(),
    };
