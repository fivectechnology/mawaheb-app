import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel extends Equatable {
  const LoginResponseModel({
    required this.message,
    required this.data,
  });
  final String? message;
  final String? data;

  LoginResponseModel copyWith({String? message, String? data}) {
    return LoginResponseModel(
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [message, data];

  static LoginResponseModel fromJson(Object? json) => _$LoginResponseModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
