// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionResponse _$VersionResponseFromJson(Map<String, dynamic> json) {
  return VersionResponse(
    json['id'] as int?,
    json['version'] as int?,
  );
}

Map<String, dynamic> _$VersionResponseToJson(VersionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
    };
