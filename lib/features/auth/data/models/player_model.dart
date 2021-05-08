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
    @required this.tName,
    @required this.email,
    @required this.language,
    @required this.type,
    @required this.legEn,
    @required this.tLeg,
    @required this.handEn,
    @required this.tHand,
    @required this.brief,
    @required this.height,
    @required this.weight,
    @required this.genderEn,
    @required this.tGender,
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
    @required this.photoId,
    @required int id,
    @required int version,
  }) : super(id, version);

  @JsonKey(name: 'fullNameAr')
  final String tName;
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'legTitle')
  final String tLeg;
  @JsonKey(name: 'leg')
  final String legEn;

  @JsonKey(name: 'handTitle')
  final String tHand;
  @JsonKey(name: 'hand')
  final String handEn;

  @JsonKey(name: 'genderTitle')
  final String tGender;
  @JsonKey(name: 'gender')
  final String genderEn;

  final String email;
  final String code;
  final String language;
  final String type;

  final String brief;
  final String height;
  final String weight;
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
  @JsonKey(name: 'photo.fileUUID')
  final String photoId;

  PlayerModel copyWith(
      {String code,
      String name,
      String email,
      String language,
      String type,
      String legEn,
      String tLeg,
      String handEn,
      String tHand,
      String brief,
      int height,
      int weight,
      String tGender,
      String genderEn,
      String address,
      String dateOfBirth,
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
      String tName,
      String photoId,
      List<VideoModel> videos}) {
    return PlayerModel(
      code: code ?? this.code,
      photoId: photoId ?? this.photoId,
      name: name ?? this.name,
      tName: tName ?? this.tName,
      email: email ?? this.email,
      language: language ?? this.language,
      type: type ?? this.type,
      tLeg: tLeg ?? this.tLeg,
      tHand: tHand ?? this.tHand,
      legEn: legEn ?? this.legEn,
      handEn: handEn ?? this.handEn,
      brief: brief ?? this.brief,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      genderEn: genderEn ?? this.genderEn,
      tGender: tGender ?? this.tGender,
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
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  // String get name => tName ?? nameEn;

  String get leg => tLeg ?? legEn;

  String get hand => tHand ?? handEn;

  String get gender => tGender ?? genderEn;

  @override
  List<Object> get props {
    return [
      code,
      name,
      tName,
      email,
      language,
      type,
      tHand,
      tLeg,
      handEn,
      legEn,
      brief,
      height,
      weight,
      genderEn,
      tGender,
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
      photoId,
    ];
  }

  static PlayerModel fromJson(Object json) => _$PlayerModelFromJson(json);

  static PlayerModel fromUi({
    @required String email,
    @required String password,
  }) =>
      PlayerModel(
          name: null,
          tName: null,
          email: email,
          password: password,
          code: null,
          membership: null,
          photoId: null,
          language: null,
          type: null,
          photo: null,
          tLeg: null,
          tHand: null,
          handEn: null,
          legEn: null,
          brief: null,
          height: null,
          weight: null,
          tGender: null,
          genderEn: null,
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
          availability: null);

  static PlayerModel loggedPlayerId({
    @required int id,
  }) =>
      PlayerModel(
          id: id,
          name: null,
          tName: null,
          email: null,
          photoId: null,
          password: null,
          membership: null,
          code: null,
          language: null,
          type: null,
          tLeg: null,
          tHand: null,
          handEn: null,
          legEn: null,
          brief: null,
          height: null,
          weight: null,
          tGender: null,
          genderEn: null,
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
          subscription: null,
          availability: null);

  Map<String, dynamic> toJson() => _$PlayerModelToJson(this);
}
