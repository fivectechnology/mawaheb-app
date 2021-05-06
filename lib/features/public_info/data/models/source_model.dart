import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'source_model.g.dart';

@JsonSerializable()
class SourceModel extends VersionModel with EquatableMixin {
  const SourceModel({
    @required this.fileName,
    @required this.fileUUID,
    @required int id,
    @required int version,
  }) : super(id, version);

  final String fileName;
  final String fileUUID;

  SourceModel copyWith({
    String fileName,
    int id,
    int version,
    String fileUUID,
  }) {
    return SourceModel(
      fileName: fileName ?? this.fileName,
      fileUUID: fileUUID ?? this.fileUUID,
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      fileName,
      fileUUID,
      id,
      version,
    ];
  }

  static SourceModel fromJson(Object json) => _$SourceModelFromJson(json);
  Map<String, dynamic> toJson() => _$SourceModelToJson(this);
}
