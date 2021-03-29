import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';

import 'base_response_model.dart';

abstract class BaseModel {
  const BaseModel(this.status, this.offset, this.total, this.errors);
  final int status;
  final int offset;
  final int total;
  final Map<String, dynamic> errors;
}

typedef BaseMapper<T> = BaseResponseModel<T> Function(Map<String, dynamic>);

typedef ListMapper<T> = ListBaseResponseModel<T> Function(Map<String, dynamic>);
