import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';

part 'partner_member_model.g.dart';

@JsonSerializable()
class PartnerMemberModel with EquatableMixin {
  const PartnerMemberModel({
    required this.player,
    required this.status,
    required this.id,
    required this.$version,
  });

  final PlayerModel? player;
  final String? status;
  final int? id;
  final int? $version;

  PartnerMemberModel copyWith({
    String? status,
    PlayerModel? player,
    int? id,
    int? $version,
  }) {
    return PartnerMemberModel(
      player: player ?? this.player,
      status: status ?? this.status,
      id: id ?? this.id,
      $version: $version ?? this.$version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      player,
      status,
      id,
      $version,
    ];
  }

  static PartnerMemberModel fromJson(Object json) =>
      _$PartnerMemberModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$PartnerMemberModelToJson(this);
}
