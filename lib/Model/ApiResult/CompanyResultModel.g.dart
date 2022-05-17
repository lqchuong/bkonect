// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CompanyResultModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyResultModel _$CompanyResultModelFromJson(Map<String, dynamic> json) {
  return CompanyResultModel()
    ..db = json['db'] == null
        ? null
        : CompanyModel.fromJson(json['db'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CompanyResultModelToJson(CompanyResultModel instance) =>
    <String, dynamic>{
      'db': instance.db,
    };
