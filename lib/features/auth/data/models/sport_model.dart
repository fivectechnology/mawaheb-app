import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'sport_model.g.dart';

@JsonSerializable()
class SportModel extends VersionModel with EquatableMixin {
  const SportModel({
    @required this.name,
    @required int id,
    @required int version,
  }) : super(id, version);

  final String name;

  SportModel copyWith({
    String name,
    int id,
    int version,
  }) {
    return SportModel(
      name: name ?? this.name,
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
      id,
      version,
    ];
  }

  static SportModel fromJson(Object json) => _$SportModelFromJson(json);
  Map<String, dynamic> toJson() => _$SportModelToJson(this);
}
