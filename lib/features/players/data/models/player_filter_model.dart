import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';

part 'player_filter_model.g.dart';

@JsonSerializable()
class PlayerFilterModel extends Equatable {
  const PlayerFilterModel({
    required this.country,
    required this.sport,
    required this.position,
    required this.hand,
    required this.leg,
    required this.name,
    required this.partnerId,
    required this.isConfirmed,
    required this.isBooked,
  });
  final CountryModel? country;
  final SportModel? sport;
  final SportPositionModel? position;
  final String? hand;
  final String? leg;
  final String? name;
  final int? partnerId;
  final bool? isConfirmed;
  final bool? isBooked;

  int? get countryId => country?.id;
  int? get sportId => sport?.id;
  int? get positionId => position?.id;

  PlayerFilterModel copyWith({
    CountryModel? country,
    SportModel? sport,
    SportPositionModel? position,
    String? hand,
    String? leg,
    String? name,
    int? partnerId,
    bool? isConfirmed,
    bool? isBooked,
  }) {
    return PlayerFilterModel(
      country: country ?? this.country,
      sport: sport ?? this.sport,
      position: position ?? this.position,
      hand: hand ?? this.hand,
      leg: leg ?? this.leg,
      name: name ?? this.name,
      partnerId: partnerId ?? this.partnerId,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      isBooked: isBooked ?? this.isBooked,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      country,
      sport,
      position,
      hand,
      leg,
      name,
      partnerId,
      isConfirmed,
      isBooked,
    ];
  }

  static PlayerFilterModel initial() => const PlayerFilterModel(
        country: null,
        hand: null,
        isBooked: false,
        isConfirmed: false,
        leg: null,
        name: null,
        partnerId: null,
        position: null,
        sport: null,
      );

  static PlayerFilterModel fromJson(Object json) => _$PlayerFilterModelFromJson(json as Map<String, dynamic>);
  Map<String, dynamic> toJson() => _$PlayerFilterModelToJson(this);
}
