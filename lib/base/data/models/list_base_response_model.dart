import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/base_model.dart';

part 'list_base_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ListBaseResponseModel<T> extends BaseModel with EquatableMixin {
  const ListBaseResponseModel(
    int status,
    int offset,
    int total,
    Map<String, dynamic> errors,
    // String message,
    this.data,
  ) : super(status, offset, total, errors /* , message*/);

  final List<T> data;

  ListBaseResponseModel<T> copyWith({
    int status,
    int offset,
    int total,
    Map<String, dynamic> errors,
    // String message,
    List<T> data,
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
  List<Object> get props => [status, offset, total, errors, data];

  static ListMapper<R> fromJson<R>(R Function(Object) fromJsonT) =>
      (Object baseJson) => _$ListBaseResponseModelFromJson(
            baseJson,
            (contentJson) => fromJsonT(contentJson),
          );

  Map<String, dynamic> toJson(
    Object Function(T value) toJsonT,
  ) =>
      _$ListBaseResponseModelToJson(this, toJsonT);
}
