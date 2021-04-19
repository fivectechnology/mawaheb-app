import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_response_model.g.dart';

@JsonSerializable()
class OTPResponseModel with EquatableMixin {
  const OTPResponseModel({
    @required this.message,
    @required this.data,
    @required this.status,
  });

  final String message;
  final int data;
  final int status;

  OTPResponseModel copyWith({
    String message,
    int data,
    String status,
  }) {
    return OTPResponseModel(
      message: message ?? this.message,
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      message,
      status,
      data,
    ];
  }

  static OTPResponseModel fromJson(Object json) =>
      _$OTPResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$OTPResponseModelToJson(this);
}
