import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/source_model.dart';

part 'gallery_model.g.dart';

@JsonSerializable()
class GalleryModel extends VersionModel with EquatableMixin {
  const GalleryModel({
    @required this.title,
    @required this.source,
    @required int id,
    @required int version,
  }) : super(id, version);

  final String title;
  final SourceModel source;

  GalleryModel copyWith({
    String title,
    SourceModel source,
    int id,
    int version,
  }) {
    return GalleryModel(
      title: title ?? this.title,
      source: source ?? this.source,
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
      source,
      id,
      version,
    ];
  }

  static GalleryModel fromJson(Object json) => _$GalleryModelFromJson(json);

  Map<String, dynamic> toJson() => _$GalleryModelToJson(this);
}
