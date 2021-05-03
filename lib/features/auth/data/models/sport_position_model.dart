import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';

part 'sport_position_model.g.dart';

@JsonSerializable()
class SportPositionModel extends VersionModel with EquatableMixin {
  const SportPositionModel({
    @required this.name,
    @required this.tName,
    @required this.sport,
    @required int id,
    @required int version,
  }) : super(id, version);

  @JsonKey(name: r'$t:name')
  final String tName;
  final String name;
  final SportModel sport;

  SportPositionModel copyWith({
    String name,
    String tName,
    SportModel sport,
    int id,
    int version,
  }) {
    return SportPositionModel(
      name: name ?? this.name,
      tName: tName ?? this.tName,
      sport: sport ?? this.sport,
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      name,
      sport,
      tName,
      id,
      version,
    ];
  }

  static SportPositionModel fromJson(Object json) =>
      _$SportPositionModelFromJson(json);
  Map<String, dynamic> toJson() => _$SportPositionModelToJson(this);
}
