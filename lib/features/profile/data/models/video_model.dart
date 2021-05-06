import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/source_model.dart';

part 'video_model.g.dart';

@JsonSerializable()
class VideoModel extends VersionModel with EquatableMixin {
  const VideoModel({
    @required this.status,
    @required this.video,
    @required this.videoUid,
    @required int id,
    @required int version,
  }) : super(id, version);

  final String status;
  final SourceModel video;

  @JsonKey(name: 'video.fileUUID')
  final String videoUid;

  VideoModel copyWith({
    String status,
    SourceModel video,
    int id,
    int version,
    String videoUid,
  }) {
    return VideoModel(
      status: status ?? this.status,
      video: video ?? this.video,
      videoUid: videoUid ?? this.videoUid,
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      status,
      video,
      videoUid,
      id,
      version,
    ];
  }

  static VideoModel fromJson(Object json) => _$VideoModelFromJson(json);
  Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}
