import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@JsonSerializable()
class CountryModel with EquatableMixin {
  const CountryModel({
    @required this.tName,
    @required this.nameEn,
    @required this.id,
  });

  @JsonKey(name: r'$t:name')
  final String tName;
  @JsonKey(name: 'name')
  final String nameEn;
  final int id;

  CountryModel copyWith({
    String nameEn,
    String tName,
    int id,
  }) {
    return CountryModel(
      tName: tName ?? this.tName,
      nameEn: nameEn ?? this.nameEn,
      id: id ?? this.id,
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
    ];
  }

  static CountryModel fromJson(Object json) => _$CountryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}
