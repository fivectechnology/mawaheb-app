// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerModel _$PlayerModelFromJson(Map<String, dynamic> json) {
  return PlayerModel(
    code: json['code'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    language: json['language'] as String,
    type: json['type'] as String,
    leg: json['leg'] as String,
    hand: json['hand'] as String,
    brief: json['brief'] as String,
    height: json['height'] as String,
    weight: json['weight'] as String,
    gender: json['gender'] as String,
    address: json['address'] as String,
    dateOfBirth: json['dateOfBirth'] as String,
    phone: json['phone'] as String,
    area: json['area'] as String,
    id: json['id'] as int,
    version: json['version'] as int,
  );
}

Map<String, dynamic> _$PlayerModelToJson(PlayerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'name': instance.name,
      'email': instance.email,
      'code': instance.code,
      'language': instance.language,
      'type': instance.type,
      'leg': instance.leg,
      'hand': instance.hand,
      'brief': instance.brief,
      'height': instance.height,
      'weight': instance.weight,
      'gender': instance.gender,
      'address': instance.address,
      'dateOfBirth': instance.dateOfBirth,
      'phone': instance.phone,
      'area': instance.area,
    };
