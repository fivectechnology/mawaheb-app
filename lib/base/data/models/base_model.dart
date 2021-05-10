import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';

import 'base_response_model.dart';

abstract class BaseModel {
  const BaseModel(this.status, this.offset, this.total, this.errors /* , this.message */);

  ///  [status]
  ///  0 success
  /// -1 failure
  /// -4 validation error
  final int? status;

  final int? offset;

  final int? total;

  // final String message;

  final Map<String, dynamic>? errors;
}

typedef BaseMapper<T> = BaseResponseModel<T> Function(Map<String, dynamic>?);

// typedef ListMapper<T> = ListBaseResponseModel<T> Function(Map<String, dynamic>);
typedef ListMapper<T> = ListBaseResponseModel<T> Function(Object);
