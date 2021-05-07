import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'emirate_model.g.dart';

@JsonSerializable()
class EmirateModel with EquatableMixin {
  const EmirateModel({
    @required this.nameEn,
    @required this.tName,
    @required this.id,
  });

  @JsonKey(name: r'$t:name')
  final String tName;
  @JsonKey(name: 'name')
  final String nameEn;

  final int id;

  EmirateModel copyWith({
    String nameEn,
    String tName,
    int id,
  }) {
    return EmirateModel(
      nameEn: nameEn ?? this.nameEn,
      tName: tName ?? this.tName,
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
      tName,
      id,
    ];
  }

  static EmirateModel fromJson(Object json) => _$EmirateModelFromJson(json);
  Map<String, dynamic> toJson() => _$EmirateModelToJson(this);
}
