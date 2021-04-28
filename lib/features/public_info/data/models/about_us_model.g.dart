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
    ourValues: json['ourValues'] as String,
    summaryAr: json['summaryAr'] as String,
    visionAr: json['visionAr'] as String,
    missionAr: json['missionAr'] as String,
    ourValuesAr: json['ourValuesAr'] as String,
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
      'ourValues': instance.ourValues,
      'summaryAr': instance.summaryAr,
      'visionAr': instance.visionAr,
      'missionAr': instance.missionAr,
      'ourValuesAr': instance.ourValuesAr,
    };
