import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/source_model.dart';

part 'download_center_model.g.dart';

@JsonSerializable()
class DownloadCenterModel extends VersionModel with EquatableMixin {
  const DownloadCenterModel({
    required this.title,
    required this.sourceId,
    required this.source,
    required this.titleAr,
    required int? id,
    required int? version,
  }) : super(id, version);

  @JsonKey(name: 'source.fileUUID')
  final String? sourceId;

  final String? title;
  final String? titleAr;
  final SourceModel? source;

  DownloadCenterModel copyWith({
    String? title,
    String? titleAr,
    SourceModel? source,
    String? sourceId,
    int? id,
    int? version,
  }) {
    return DownloadCenterModel(
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
  List<Object?> get props {
    return [
      title,
      source,
      id,
      version,
      titleAr,
      sourceId,
    ];
  }

  static DownloadCenterModel fromJson(Object json) =>
      _$DownloadCenterModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$DownloadCenterModelToJson(this);
}
