import 'dart:async';

import 'package:core_sdk/utils/network_result.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/base_model.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';
import 'package:mobx/mobx.dart';
import 'package:core_sdk/utils/extensions/future.dart';
import 'package:core_sdk/utils/extensions/object.dart';

part 'list_base_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ListBaseResponseModel<T> extends BaseModel with EquatableMixin {
  const ListBaseResponseModel(
    int? status,
    int? offset,
    int? total,
    Map<String, dynamic>? errors,
    // String message,
    this.data,
  ) : super(status, offset, total, errors /* , message*/);

  final List<T>? data;

  ListBaseResponseModel<T> copyWith({
    int? status,
    int? offset,
    int? total,
    Map<String, dynamic>? errors,
    // String message,
    List<T>? data,
  }) {
    return ListBaseResponseModel<T>(
      status ?? this.status,
      offset ?? this.offset,
      total ?? this.total,
      errors ?? this.errors,
      // message ?? this.message,
      data ?? this.data,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, offset, total, errors, data];

  static ListBaseResponseModel<R> Function(Object?) fromJson<R>(R Function(Object) fromJsonT) =>
      (Object? baseJson) => _$ListBaseResponseModelFromJson(
            baseJson as Map<String, dynamic>,
            (contentJson) => fromJsonT(contentJson!),
          );

  static List<R> Function(Object?) dataTypeMapper<R>(R Function(Object?) fromJsonT) =>
      (Object? baseJson) => _$ListBaseResponseModelFromJson(
            baseJson as Map<String, dynamic>,
            fromJsonT,
          ).data!;

  static VersionResponse Function(Object?) get versionMapper => (Object? baseJson) => _$ListBaseResponseModelFromJson(
        baseJson as Map<String, dynamic>,
        VersionResponse.fromJson,
      ).data!.first;

  Map<String, dynamic> toJson(
    Object Function(T value) toJsonT,
  ) =>
      _$ListBaseResponseModelToJson(this, toJsonT);

  ListBaseResponseModel<T> merge(ListBaseResponseModel<T> newObject) {
    return ListBaseResponseModel<T>(
      newObject.status ?? status,
      newObject.offset ?? offset,
      newObject.total ?? total,
      newObject.errors ?? errors,
      data?..addAll(newObject.data!),
    );
  }

  static ListBaseResponseModel<T> defaultParams<T>() {
    return ListBaseResponseModel<T>(null, null, null, null, []);
  }
}

extension PaginationExtension<T> on Future<NetworkResult<ListBaseResponseModel<T>?>> {
  Future<ListBaseResponseModel<T>> replace({
    required ObservableFuture<ListBaseResponseModel<T>>? oldValue,
    required VoidCallback onSuccess,
  }) {
    return whenSuccess(
      ((res) => res!.total == 0
          ? res
          : (oldValue?.value ?? ListBaseResponseModel.defaultParams<T>()).merge(res).apply(onSuccess)),
    );
  }
}
