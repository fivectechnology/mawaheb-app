import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:mawaheb_app/base/data/models/base_model.dart';

part 'base_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponseModel<T> extends BaseModel with EquatableMixin {
  const BaseResponseModel(
    int status,
    int offset,
    int total,
    Map<String, dynamic> errors,
    // String message,
    this.data,
  ) : super(status, offset, total, errors /* , message */);

  BaseResponseModel<T> copyWith({
    int status,
    int offset,
    int total,
    Map<String, dynamic> errors,
    // String message,
    T data,
  }) {
    return BaseResponseModel<T>(
      status ?? this.status,
      offset ?? this.offset,
      total ?? this.total,
      errors ?? this.errors,
      // message ?? this.message,
      data ?? this.data,
    );
  }

  final T data;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [status, offset, total, errors, data];

  static BaseMapper<R> fromJson<R>(R Function(Object) fromJsonT) => (Object baseJson) => _$BaseResponseModelFromJson(
        baseJson,
        fromJsonT,
      );

  static bool Function(Object) get successMapper =>
      (Object baseJson) => _$BaseResponseModelFromJson(baseJson, (_) => Null).status == 0;

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$BaseResponseModelToJson(this, toJsonT);
}
