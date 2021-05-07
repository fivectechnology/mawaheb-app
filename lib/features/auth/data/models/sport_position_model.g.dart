// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_position_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportPositionModel _$SportPositionModelFromJson(Map<String, dynamic> json) {
  return SportPositionModel(
    nameEn: json['name'] as String,
    tName: json[r'$t:name'] as String,
    sport: json['sport'] == null
        ? null
        : SportModel.fromJson(json['sport'] as Map<String, dynamic>),
    id: json['id'] as int,
    version: json['version'] as int,
  );
}

Map<String, dynamic> _$SportPositionModelToJson(SportPositionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      r'$t:name': instance.tName,
      'name': instance.nameEn,
      'sport': instance.sport,
    };
