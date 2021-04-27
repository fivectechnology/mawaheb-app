import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'country_model.g.dart';

@JsonSerializable()
class CountryModel extends VersionModel with EquatableMixin {
  const CountryModel({
    @required this.name,
    @required int id,
    @required int version,
  }) : super(id, version);

  @JsonKey(name: '\$t:name')
  final String name;

  CountryModel copyWith({
    String name,
    int id,
    int version,
  }) {
    return CountryModel(
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

  static CountryModel fromJson(Object json) => _$CountryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}
