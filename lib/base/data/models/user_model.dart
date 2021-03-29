import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  const UserModel({
    @required this.mobile,
    @required this.password,
  });

  final String mobile;

  final String password;

  UserModel copyWith({
    String mobile,
    String password,
  }) {
    return UserModel(
      mobile: mobile ?? this.mobile,
      password: password ?? this.password,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [mobile, password];

  static UserModel fromJson(Object json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
