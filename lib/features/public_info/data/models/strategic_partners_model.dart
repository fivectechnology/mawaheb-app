import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/source_model.dart';

part 'strategic_partners_model.g.dart';

@JsonSerializable()
class StrategicPartnersModel extends VersionModel with EquatableMixin {
  const StrategicPartnersModel({
    @required this.title,
    @required this.sourceId,
    @required this.source,
    @required this.titleAr,
    @required int id,
    @required int version,
  }) : super(id, version);

  @JsonKey(name: 'source.fileUUID')
  final String sourceId;
  final String title;
  final String titleAr;
  final SourceModel source;

  StrategicPartnersModel copyWith({
    String title,
    SourceModel source,
    int id,
    int version,
    String sourceId,
    String titleAr,
  }) {
    return StrategicPartnersModel(
      title: title ?? this.title,
      titleAr: titleAr ?? this.titleAr,
      source: source ?? this.source,
      sourceId: sourceId ?? this.sourceId,
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      title,
      titleAr,
      source,
      id,
      sourceId,
      version,
    ];
  }

  static StrategicPartnersModel fromJson(Object json) =>
      _$StrategicPartnersModelFromJson(json);

  Map<String, dynamic> toJson() => _$StrategicPartnersModelToJson(this);
}
