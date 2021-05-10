// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) {
  return VideoModel(
    tStatus: json['statusTitle'] as String?,
    statusEn: json['status'] as String?,
    video: json['video'] == null
        ? null
        : SourceModel.fromJson(json['video'] as Map<String, dynamic>),
    videoUid: json['video.fileUUID'] as String?,
    id: json['id'] as int?,
    version: json['version'] as int?,
  );
}

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'video': instance.video,
      'video.fileUUID': instance.videoUid,
      'statusTitle': instance.tStatus,
      'status': instance.statusEn,
    };
