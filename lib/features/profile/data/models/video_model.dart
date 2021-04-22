import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'video_model.g.dart';

@JsonSerializable()
class VideoModel extends VersionModel with EquatableMixin {
  const VideoModel({
    @required int id,
    @required int version,
  }) : super(id, version);

  VideoModel copyWith({
    int id,
    int version,
  }) {
    return VideoModel(
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      version,
    ];
  }

  static VideoModel fromJson(Object json) => _$VideoModelFromJson(json);
  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}
