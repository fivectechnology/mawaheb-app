// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportModel _$SportModelFromJson(Map<String, dynamic> json) {
  return SportModel(
    name2: json['name'] as String?,
    tName: json[r'$t:name'] as String?,
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$SportModelToJson(SportModel instance) =>
    <String, dynamic>{
      r'$t:name': instance.tName,
      'name': instance.name2,
      'id': instance.id,
    };
