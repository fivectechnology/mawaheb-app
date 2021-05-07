// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emirate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmirateModel _$EmirateModelFromJson(Map<String, dynamic> json) {
  return EmirateModel(
    nameEn: json['name'] as String,
    tName: json[r'$t:name'] as String,
    id: json['id'] as int,
    version: json['version'] as int,
  );
}

Map<String, dynamic> _$EmirateModelToJson(EmirateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      r'$t:name': instance.tName,
      'name': instance.nameEn,
    };
