// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseModel<T> _$BaseResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return BaseResponseModel<T>(
    json['status'] as int?,
    json['offset'] as int?,
    json['total'] as int?,
    json['errors'] as Map<String, dynamic>?,
    fromJsonT(json['data']),
  );
}

Map<String, dynamic> _$BaseResponseModelToJson<T>(
  BaseResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'offset': instance.offset,
      'total': instance.total,
      'errors': instance.errors,
      'data': toJsonT(instance.data),
    };
