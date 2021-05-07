import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'sport_model.g.dart';

@JsonSerializable()
class SportModel with EquatableMixin {
  const SportModel({
    @required this.name2,
    @required this.tName,
    @required this.id,
  });

  @JsonKey(name: r'$t:name')
  final String tName;
  @JsonKey(name: 'name')
  final String name2;

  final int id;

  SportModel copyWith({
    String name2,
    String tName,
    int id,
  }) {
    return SportModel(
      name2: name2 ?? this.name2,
      tName: tName ?? this.tName,
      id: id ?? this.id,
    );
  }

  @override
  bool get stringify => true;

  String get name => tName ?? name2;

  @override
  List<Object> get props {
    return [
      name,
      tName,
      id,
    ];
  }

  static SportModel fromJson(Object json) => _$SportModelFromJson(json);
  Map<String, dynamic> toJson() => _$SportModelToJson(this);
}
