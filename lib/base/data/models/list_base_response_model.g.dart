// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_base_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListBaseResponseModel<T> _$ListBaseResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object json) fromJsonT,
) {
  return ListBaseResponseModel<T>(
    json['status'] as int,
    json['offset'] as int,
    json['total'] as int,
    json['errors'] as Map<String, dynamic>,
    (json['data'] as List)?.map(fromJsonT)?.toList(),
  );
}

Map<String, dynamic> _$ListBaseResponseModelToJson<T>(
  ListBaseResponseModel<T> instance,
  Object Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'offset': instance.offset,
      'total': instance.total,
      'errors': instance.errors,
      'data': instance.data?.map(toJsonT)?.toList(),
    };
