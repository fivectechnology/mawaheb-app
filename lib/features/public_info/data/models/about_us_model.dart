import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'about_us_model.g.dart';

@JsonSerializable()
class AboutUsModel extends VersionModel with EquatableMixin {
  const AboutUsModel({
    required this.summary,
    required this.vision,
    required this.mission,
    required this.ourValues,
    required this.summaryAr,
    required this.visionAr,
    required this.missionAr,
    required this.ourValuesAr,
    required int? id,
    required int? version,
  }) : super(id, version);

  final String? summary;
  final String? vision;
  final String? mission;
  final String? ourValues;
  final String? summaryAr;
  final String? visionAr;
  final String? missionAr;
  final String? ourValuesAr;

  AboutUsModel copyWith({
    String? summary,
    String? vision,
    String? mission,
    String? ourValues,
    int? id,
    int? version,
    String? summaryAr,
    String? visionAr,
    String? missionAr,
    String? ourValuesAr,
  }) {
    return AboutUsModel(
      summary: summary ?? this.summary,
      vision: vision ?? this.vision,
      mission: mission ?? this.mission,
      ourValues: ourValues ?? this.ourValues,
      summaryAr: summaryAr ?? this.summaryAr,
      visionAr: visionAr ?? this.visionAr,
      missionAr: missionAr ?? this.missionAr,
      ourValuesAr: ourValuesAr ?? this.ourValuesAr,
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [summary, vision, mission, ourValues, id, version, summaryAr, visionAr, ourValues, ourValuesAr];
  }

  static AboutUsModel fromJson(Object json) => _$AboutUsModelFromJson(json as Map<String, dynamic>);
  Map<String, dynamic> toJson() => _$AboutUsModelToJson(this);
}
