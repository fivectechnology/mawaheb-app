// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return CategoryModel(
    titleEn: json['title'] as String?,
    tTitle: json[r'$t:title'] as String?,
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      r'$t:title': instance.tTitle,
      'title': instance.titleEn,
      'id': instance.id,
    };
