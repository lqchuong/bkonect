// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ContentResultModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentResultModel _$ContentResultModelFromJson(Map<String, dynamic> json) {
  return ContentResultModel()
    ..db = json['db'] == null
        ? null
        : EventProgramModel.fromJson(json['db'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ContentResultModelToJson(ContentResultModel instance) =>
    <String, dynamic>{
      'db': instance.db,
    };
