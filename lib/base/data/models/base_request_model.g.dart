// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRequestModel<T> _$BaseRequestModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object json) fromJsonT,
) {
  return BaseRequestModel<T>(
    json['model'] as String,
    json['offset'] as int,
    json['limit'] as int,
    (json['sortBy'] as List)?.map((e) => e as String)?.toList(),
    fromJsonT(json['data']),
    json['records'] as List,
    (json['fields'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$BaseRequestModelToJson<T>(
  BaseRequestModel<T> instance,
  Object Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'model': instance.model,
      'offset': instance.offset,
      'limit': instance.limit,
      'sortBy': instance.sortBy,
      'data': toJsonT(instance.data),
      'records': instance.records,
      'fields': instance.fields,
    };
