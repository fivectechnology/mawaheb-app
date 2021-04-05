import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  const UserModel({
    @required this.userName,
    @required this.password,
  });

  final String userName;

  final String password;

  UserModel copyWith({
    String userName,
    String password,
    String baseToken,
  }) {
    return UserModel(
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [userName, password];

  static UserModel fromJson(Object json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
