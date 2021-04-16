// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPResponseModel _$OTPResponseModelFromJson(Map<String, dynamic> json) {
  return OTPResponseModel(
    message: json['message'] as String,
    data: json['data'] as String,
    code: json['code'] as int,
  );
}

Map<String, dynamic> _$OTPResponseModelToJson(OTPResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
      'code': instance.code,
    };
