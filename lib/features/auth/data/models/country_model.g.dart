// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) {
  return CountryModel(
    name: json[r'$t:name'] as String,
    id: json['id'] as int,
    version: json['version'] as int,
  );
}

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      r'$t:name': instance.name,
    };
