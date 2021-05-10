// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) {
  return CountryModel(
    tName: json[r'$t:name'] as String?,
    nameEn: json['name'] as String?,
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      r'$t:name': instance.tName,
      'name': instance.nameEn,
      'id': instance.id,
    };
