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
    @required this.language,
    @required this.type,
    @required this.leg,
    @required this.hand,
    @required this.brief,
    @required this.height,
    @required this.weight,
    @required this.gender,
    @required this.address,
    @required this.dateOfBirth,
    @required this.phone,
    @required this.area,
    @required this.password,
    @required int id,
    @required int version,
  }) : super(id, version);

  final String name;
  final String email;
  final String code;
  final String language;
  final String type;
  final String leg;
  final String hand;
  final String brief;
  final String height;
  final String weight;
  final String gender;
  final String address;
  final String dateOfBirth;
  final String phone;
  final String area;
  final String password;

  PlayerModel copyWith({
    String code,
    String name,
    String email,
    String languag,
    String type,
    String leg,
    String hand,
    String brief,
    int height,
    int weight,
    String gender,
    String address,
    String dateOfBirth,
    String language,
    String phone,
    String area,
    int id,
    int version,
    String password,
  }) {
    return PlayerModel(
      code: code ?? this.code,
      name: name ?? this.name,
      email: email ?? this.email,
      language: language ?? this.language,
      type: type ?? this.type,
      leg: leg ?? this.leg,
      hand: hand ?? this.hand,
      brief: brief ?? this.brief,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phone: phone ?? this.phone,
      area: area ?? this.area,
      password: password ?? this.password,
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
      language,
      type,
      leg,
      hand,
      brief,
      height,
      weight,
      gender,
      address,
      dateOfBirth,
      id,
      version,
      password,
    ];
  }

  static PlayerModel fromJson(Object json) => _$PlayerModelFromJson(json);

  static PlayerModel fromUi({
    @required String name,
    @required String email,
    @required String password,
  }) =>
      PlayerModel(
        name: name,
        email: email,
        password: password,
        code: null,
        language: null,
        type: null,
        leg: null,
        hand: null,
        brief: null,
        height: null,
        weight: null,
        gender: null,
        address: null,
        dateOfBirth: null,
        phone: null,
        area: null,
        id: null,
        version: null,
      );

  Map<String, dynamic> toJson() => _$PlayerModelToJson(this);
}
