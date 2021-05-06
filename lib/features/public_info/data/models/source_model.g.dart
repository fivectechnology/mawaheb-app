// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceModel _$SourceModelFromJson(Map<String, dynamic> json) {
  return SourceModel(
    fileName: json['fileName'] as String,
    fileUUID: json['fileUUID'] as String,
    id: json['id'] as int,
    version: json['version'] as int,
  );
}

Map<String, dynamic> _$SourceModelToJson(SourceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'fileName': instance.fileName,
      'fileUUID': instance.fileUUID,
    };
