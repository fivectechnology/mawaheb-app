import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';

part 'sport_position_model.g.dart';

@JsonSerializable()
class SportPositionModel with EquatableMixin {
  const SportPositionModel({
    @required this.nameEn,
    @required this.tName,
    @required this.sport,
    @required this.id,
  });

  @JsonKey(name: r'$t:name')
  final String tName;
  @JsonKey(name: 'name')
  final String nameEn;

  final SportModel sport;
  final int id;

  SportPositionModel copyWith({
    String nameEn,
    String tName,
    SportModel sport,
    int id,
  }) {
    return SportPositionModel(
      nameEn: nameEn ?? this.nameEn,
      tName: tName ?? this.tName,
      sport: sport ?? this.sport,
      id: id ?? this.id,
    );
  }

  @override
  bool get stringify => true;

  String get name => tName ?? nameEn;

  @override
  List<Object> get props {
    return [
      nameEn,
      sport,
      tName,
      id,
    ];
  }

  static SportPositionModel fromJson(Object json) =>
      _$SportPositionModelFromJson(json);
  Map<String, dynamic> toJson() => _$SportPositionModelToJson(this);
}
