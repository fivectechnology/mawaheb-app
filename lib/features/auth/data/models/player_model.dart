import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';
import 'package:mawaheb_app/features/auth/data/models/category_model.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/data/models/emirate_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/players/data/models/partner_member_model.dart';
import 'package:mawaheb_app/features/profile/data/models/subscription_model.dart';
import 'package:mawaheb_app/features/profile/data/models/video_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/source_model.dart';

part 'player_model.g.dart';

@JsonSerializable()
class PlayerModel extends VersionModel with EquatableMixin {
  const PlayerModel({
    @required this.code,
    @required this.name,
    @required this.email,
    @required this.language,
    @required this.type,
    @required this.leg,
    @required this.hand,
    @required this.brief,
    @required this.height,
    @required this.weight,
    @required this.gender,
    @required this.address,
    @required this.dateOfBirth,
    @required this.phone,
    @required this.area,
    @required this.password,
    @required this.position,
    @required this.sport,
    @required this.emirate,
    @required this.country,
    @required this.category,
    @required this.status,
    @required this.availability,
    @required this.videos,
    @required this.photo,
    @required this.membership,
    @required this.subscription,
    @required this.fullNameAr,
    @required int id,
    @required int version,
  }) : super(id, version);

  final String name;
  final String email;
  final String code;
  final String language;
  final String type;
  final String leg;
  final String hand;
  final String brief;
  final String height;
  final String weight;
  final String gender;
  final String address;
  final String dateOfBirth;
  final String phone;
  final String area;
  final String password;
  final SportPositionModel position;
  final SportModel sport;
  final CategoryModel category;
  final EmirateModel emirate;
  final CountryModel country;
  final String status;
  final String availability;
  final List<VideoModel> videos;
  final SourceModel photo;
  final PartnerMemberModel membership;
  final SubscriptionModel subscription;
  final String fullNameAr;

  PlayerModel copyWith(
      {String code,
      String name,
      String email,
      String languag,
      String type,
      String leg,
      String hand,
      String brief,
      int height,
      int weight,
      String gender,
      String address,
      String dateOfBirth,
      String language,
      String phone,
      String area,
      int id,
      int version,
      String password,
      SportPositionModel position,
      SportModel sport,
      CategoryModel category,
      EmirateModel emirate,
      CountryModel country,
      String status,
      String availability,
      SourceModel photo,
      PartnerMemberModel membership,
      SubscriptionModel subscription,
      String fullNameAr,
      List<VideoModel> videos}) {
    return PlayerModel(
      code: code ?? this.code,
      name: name ?? this.name,
      email: email ?? this.email,
      language: language ?? this.language,
      type: type ?? this.type,
      leg: leg ?? this.leg,
      hand: hand ?? this.hand,
      brief: brief ?? this.brief,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phone: phone ?? this.phone,
      area: area ?? this.area,
      password: password ?? this.password,
      position: position ?? this.position,
      sport: sport ?? this.sport,
      category: category ?? this.category,
      emirate: emirate ?? this.emirate,
      country: country ?? this.country,
      status: status ?? this.status,
      availability: availability ?? this.availability,
      photo: photo ?? this.photo,
      videos: videos ?? this.videos,
      membership: membership ?? this.membership,
      subscription: subscription ?? this.subscription,
      fullNameAr: fullNameAr ?? this.fullNameAr,
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      code,
      name,
      email,
      language,
      type,
      leg,
      hand,
      brief,
      height,
      weight,
      gender,
      address,
      dateOfBirth,
      id,
      version,
      password,
      position,
      sport,
      category,
      emirate,
      country,
      status,
      availability,
      videos,
      photo,
      membership,
      subscription,
      fullNameAr
    ];
  }

  static PlayerModel fromJson(Object json) => _$PlayerModelFromJson(json);

  static PlayerModel fromUi({
    @required String email,
    @required String password,
  }) =>
      PlayerModel(
          name: null,
          email: email,
          password: password,
          code: null,
          membership: null,
          language: null,
          type: null,
          photo: null,
          leg: null,
          hand: null,
          brief: null,
          height: null,
          weight: null,
          gender: null,
          address: null,
          dateOfBirth: null,
          phone: null,
          area: null,
          id: null,
          version: null,
          country: null,
          position: null,
          sport: null,
          category: null,
          emirate: null,
          status: null,
          subscription: null,
          videos: null,
          fullNameAr: null,
          availability: null);

  static PlayerModel loggedPlayerId({
    @required int id,
  }) =>
      PlayerModel(
          id: id,
          name: null,
          email: null,
          password: null,
          membership: null,
          code: null,
          language: null,
          type: null,
          leg: null,
          hand: null,
          brief: null,
          height: null,
          weight: null,
          gender: null,
          address: null,
          dateOfBirth: null,
          phone: null,
          area: null,
          version: null,
          country: null,
          photo: null,
          position: null,
          sport: null,
          category: null,
          emirate: null,
          status: null,
          videos: null,
          fullNameAr: null,
          subscription: null,
          availability: null);

  Map<String, dynamic> toJson() => _$PlayerModelToJson(this);
}
