import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'partner_model.g.dart';

@JsonSerializable()
class PartnerModel extends VersionModel with EquatableMixin {
  const PartnerModel({
    @required this.name,
    @required int id,
    @required int version,
  }) : super(id, version);

  final String name;

  PartnerModel copyWith({
    String name,
    int id,
    int version,
  }) {
    return PartnerModel(
      name: name ?? this.name,
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      name,
      id,
      version,
    ];
  }

  static PartnerModel fromJson(Object json) => _$PartnerModelFromJson(json);
  Map<String, dynamic> toJson() => _$PartnerModelToJson(this);
}
