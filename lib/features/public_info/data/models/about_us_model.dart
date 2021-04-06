import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'about_us_model.g.dart';

@JsonSerializable()
class AboutUsModel extends VersionModel with EquatableMixin {
  const AboutUsModel({
    @required this.summary,
    @required this.vision,
    @required this.mission,
    @required this.ourValues,
    @required int id,
    @required int version,
  }) : super(id, version);

  final String summary;
  final String vision;
  final String mission;
  final String ourValues;

  AboutUsModel copyWith({
    String summary,
    String vision,
    String mission,
    String ourValues,
    int id,
    int version,
  }) {
    return AboutUsModel(
      summary: summary ?? this.summary,
      vision: vision ?? this.vision,
      mission: mission ?? this.mission,
      ourValues: ourValues ?? this.ourValues,
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      summary,
      vision,
      mission,
      ourValues,
      id,
      version,
    ];
  }

  static AboutUsModel fromJson(Object json) => _$AboutUsModelFromJson(json);
  Map<String, dynamic> toJson() => _$AboutUsModelToJson(this);
}
