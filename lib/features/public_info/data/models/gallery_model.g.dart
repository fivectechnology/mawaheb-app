// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GalleryModel _$GalleryModelFromJson(Map<String, dynamic> json) {
  return GalleryModel(
    sourceId: json['source.fileUUID'] as String,
    title: json['title'] as String,
    source: json['source'] == null
        ? null
        : SourceModel.fromJson(json['source'] as Map<String, dynamic>),
    titleAr: json['titleAr'] as String,
    id: json['id'] as int,
    version: json['version'] as int,
  );
}

Map<String, dynamic> _$GalleryModelToJson(GalleryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'source.fileUUID': instance.sourceId,
      'title': instance.title,
      'titleAr': instance.titleAr,
      'source': instance.source,
    };
