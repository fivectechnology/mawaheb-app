import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/source_model.dart';

part 'download_center_model.g.dart';

@JsonSerializable()
class DownloadCenterModel extends VersionModel with EquatableMixin {
  const DownloadCenterModel({
    @required this.title,
    @required this.source,
    @required this.titleAr,
    @required int id,
    @required int version,
  }) : super(id, version);

  final String title;
  final String titleAr;
  final SourceModel source;

  DownloadCenterModel copyWith({
    String title,
    String titleAr,
    SourceModel source,
    int id,
    int version,
  }) {
    return DownloadCenterModel(
      title: title ?? this.title,
      titleAr: titleAr ?? this.titleAr,
      source: source ?? this.source,
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [title, source, id, version, titleAr];
  }

  static DownloadCenterModel fromJson(Object json) =>
      _$DownloadCenterModelFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadCenterModelToJson(this);
}
