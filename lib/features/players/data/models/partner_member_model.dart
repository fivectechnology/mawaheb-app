import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';

part 'partner_member_model.g.dart';

@JsonSerializable()
class PartnerMemberModel extends VersionModel with EquatableMixin {
  const PartnerMemberModel({
    @required this.player,
    @required this.status,
    @required int id,
    @required int version,
  }) : super(id, version);

  final PlayerModel player;
  final String status;

  PartnerMemberModel copyWith({
    String status,
    PlayerModel player,
    int id,
    int version,
  }) {
    return PartnerMemberModel(
      player: player ?? this.player,
      status: status ?? this.status,
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      player,
      status,
      id,
      version,
    ];
  }

  static PartnerMemberModel fromJson(Object json) =>
      _$PartnerMemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerMemberModelToJson(this);
}
