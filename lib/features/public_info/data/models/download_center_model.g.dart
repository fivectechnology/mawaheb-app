// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_center_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadCenterModel _$DownloadCenterModelFromJson(Map<String, dynamic> json) {
  return DownloadCenterModel(
    title: json['title'] as String,
    source: json['source'] == null
        ? null
        : SourceModel.fromJson(json['source'] as Map<String, dynamic>),
    titleAr: json['titleAr'] as String,
    id: json['id'] as int,
    version: json['version'] as int,
  );
}

Map<String, dynamic> _$DownloadCenterModelToJson(
        DownloadCenterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'title': instance.title,
      'titleAr': instance.titleAr,
      'source': instance.source,
    };
