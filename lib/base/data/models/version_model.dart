import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'version_model.g.dart';

abstract class VersionModel {
  const VersionModel(this.id, this.version);

  final int id;
  final int version;
}

@JsonSerializable()
class VersionResponse extends VersionModel with EquatableMixin {
  VersionResponse(int id, int version) : super(id, version);

  VersionResponse copyWith({int id, int version}) {
    return VersionResponse(
      version ?? this.version,
      id ?? this.id,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [version, id];

  static VersionResponse fromJson(Object json) =>
      _$VersionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VersionResponseToJson(this);

  static Map<String, dynamic> get body => {
        'fields': ['version']
      };
}
