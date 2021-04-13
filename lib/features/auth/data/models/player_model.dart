import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'player_model.g.dart';

@JsonSerializable()
class PlayerModel extends VersionModel with EquatableMixin {
  const PlayerModel({
    @required this.code,
    @required this.name,
    @required this.email,
    @required int id,
    @required int version,
  }) : super(id, version);

  final String name;
  final String email;
  final int code;

  PlayerModel copyWith({
    int code,
    String name,
    String email,
    int id,
    int version,
  }) {
    return PlayerModel(
      code: code ?? this.code,
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      code,
      name,
      email,
      id,
      version,
    ];
  }

  static PlayerModel fromJson(Object json) => _$PlayerModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerModelToJson(this);
}
