import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_request_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseRequestModel<T> extends Equatable {
  const BaseRequestModel(
    this.model,
    this.offset,
    this.limit,
    this.sortBy,
    this.data,
    this.records,
    this.fields,
  );

  final String? model;
  final int? offset;
  final int? limit;
  final List<String>? sortBy;
  final T data;
  final List<dynamic>? records;
  final List<String>? fields;

  BaseRequestModel<T> copyWith({
    String? model,
    int? offset,
    int? limit,
    List<String>? sortBy,
    T? data,
    List<dynamic>? records,
    List<String>? fields,
  }) {
    return BaseRequestModel<T>(
      model ?? this.model,
      offset ?? this.offset,
      limit ?? this.limit,
      sortBy ?? this.sortBy,
      data ?? this.data,
      records ?? this.records,
      fields ?? this.fields,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      model,
      offset,
      limit,
      sortBy,
      data,
      records,
      fields,
    ];
  }

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$BaseRequestModelToJson(this, toJsonT);
}
