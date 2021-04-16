import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'otp_response_model.g.dart';

@JsonSerializable()
class OTPResponseModel with EquatableMixin {
  const OTPResponseModel({
    @required this.message,
    @required this.data,
    @required this.code,
  });

  final String message;
  final String data;
  final int code;

  OTPResponseModel copyWith({
    String message,
    String data,
    String code,
  }) {
    return OTPResponseModel(
      message: message ?? this.message,
      data: data ?? this.data,
      code: code ?? this.code,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      message,
      code,
      data,
    ];
  }

  static OTPResponseModel fromJson(Object json) =>
      _$OTPResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$OTPResponseModelToJson(this);
}
