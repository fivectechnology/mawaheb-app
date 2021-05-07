import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'country_model.g.dart';

@JsonSerializable()
class CountryModel extends VersionModel with EquatableMixin {
  const CountryModel({
    @required this.tName,
    @required this.nameEn,
    @required int id,
    @required int version,
  }) : super(id, version);

  @JsonKey(name: r'$t:name')
  final String tName;
  @JsonKey(name: 'name')
  final String nameEn;

  CountryModel copyWith({
    String nameEn,
    String tName,
    int id,
    int version,
  }) {
    return CountryModel(
      tName: tName ?? this.tName,
      nameEn: nameEn ?? this.nameEn,
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  String get name => tName ?? nameEn;

  @override
  List<Object> get props {
    return [
      tName,
      nameEn,
      id,
      version,
    ];
  }

  static CountryModel fromJson(Object json) => _$CountryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}
