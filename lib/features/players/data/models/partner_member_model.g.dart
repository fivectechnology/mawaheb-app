// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartnerMemberModel _$PartnerMemberModelFromJson(Map<String, dynamic> json) {
  return PartnerMemberModel(
    player: json['player'] == null
        ? null
        : PlayerModel.fromJson(json['player'] as Map<String, dynamic>),
    status: json['status'] as String?,
    id: json['id'] as int?,
    $version: json[r'$version'] as int?,
  );
}

Map<String, dynamic> _$PartnerMemberModelToJson(PartnerMemberModel instance) =>
    <String, dynamic>{
      'player': instance.player,
      'status': instance.status,
      'id': instance.id,
      r'$version': instance.$version,
    };
