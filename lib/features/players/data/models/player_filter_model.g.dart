// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerFilterModel _$PlayerFilterModelFromJson(Map<String, dynamic> json) {
  return PlayerFilterModel(
    country: json['country'] == null
        ? null
        : CountryModel.fromJson(json['country'] as Map<String, dynamic>),
    sport: json['sport'] == null
        ? null
        : SportModel.fromJson(json['sport'] as Map<String, dynamic>),
    position: json['position'] == null
        ? null
        : SportPositionModel.fromJson(json['position'] as Map<String, dynamic>),
    hand: json['hand'] as String,
    leg: json['leg'] as String,
    name: json['name'] as String,
    partnerId: json['partnerId'] as int,
    isConfirmed: json['isConfirmed'] as bool,
    isBooked: json['isBooked'] as bool,
  );
}

Map<String, dynamic> _$PlayerFilterModelToJson(PlayerFilterModel instance) =>
    <String, dynamic>{
      'country': instance.country,
      'sport': instance.sport,
      'position': instance.position,
      'hand': instance.hand,
      'leg': instance.leg,
      'name': instance.name,
      'partnerId': instance.partnerId,
      'isConfirmed': instance.isConfirmed,
      'isBooked': instance.isBooked,
    };
