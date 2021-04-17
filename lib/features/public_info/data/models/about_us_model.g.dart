// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_us_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutUsModel _$AboutUsModelFromJson(Map<String, dynamic> json) {
  return AboutUsModel(
    summary: json['summary'] as String,
    vision: json['vision'] as String,
    mission: json['mission'] as String,
    coreValues: json['coreValues'] as String,
    id: json['id'] as int,
    version: json['version'] as int,
  );
}

Map<String, dynamic> _$AboutUsModelToJson(AboutUsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'summary': instance.summary,
      'vision': instance.vision,
      'mission': instance.mission,
      'coreValues': instance.coreValues,
    };
