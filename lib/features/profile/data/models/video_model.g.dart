// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) {
  return VideoModel(
    status: json['status'] as String,
    video: json['video'] == null
        ? null
        : SourceModel.fromJson(json['video'] as Map<String, dynamic>),
    id: json['id'] as int,
    version: json['version'] as int,
  );
}

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'status': instance.status,
      'video': instance.video,
    };
