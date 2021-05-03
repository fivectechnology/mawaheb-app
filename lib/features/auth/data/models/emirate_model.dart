import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'emirate_model.g.dart';

@JsonSerializable()
class EmirateModel extends VersionModel with EquatableMixin {
  const EmirateModel({
    @required this.name,
    @required this.tName,
    @required int id,
    @required int version,
  }) : super(id, version);

  @JsonKey(name: r'$t:name')
  final String tName;
  final String name;

  EmirateModel copyWith({
    String name,
    String tName,
    int id,
    int version,
  }) {
    return EmirateModel(
      name: name ?? this.name,
      tName: tName ?? this.tName,
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
      tName,
      id,
      version,
    ];
  }

  static EmirateModel fromJson(Object json) => _$EmirateModelFromJson(json);
  Map<String, dynamic> toJson() => _$EmirateModelToJson(this);
}
