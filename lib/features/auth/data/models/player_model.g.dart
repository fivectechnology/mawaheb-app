// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerModel _$PlayerModelFromJson(Map<String, dynamic> json) {
  return PlayerModel(
    code: json['code'] as String?,
    name: json['name'] as String?,
    tName: json['fullNameAr'] as String?,
    email: json['email'] as String?,
    language: json['language'] as String?,
    type: json['type'] as String?,
    legEn: json['leg'] as String?,
    tLeg: json['legTitle'] as String?,
    handEn: json['hand'] as String?,
    tHand: json['handTitle'] as String?,
    brief: json['brief'] as String?,
    height: json['height'] as String?,
    weight: json['weight'] as String?,
    genderEn: json['gender'] as String?,
    tGender: json['genderTitle'] as String?,
    address: json['address'] as String?,
    dateOfBirth: json['dateOfBirth'] as String?,
    phone: json['phone'] as String?,
    area: json['area'] as String?,
    password: json['password'] as String?,
    position: json['position'] == null
        ? null
        : SportPositionModel.fromJson(json['position'] as Map<String, dynamic>),
    sport: json['sport'] == null
        ? null
        : SportModel.fromJson(json['sport'] as Map<String, dynamic>),
    emirate: json['emirate'] == null
        ? null
        : EmirateModel.fromJson(json['emirate'] as Map<String, dynamic>),
    country: json['country'] == null
        ? null
        : CountryModel.fromJson(json['country'] as Map<String, dynamic>),
    category: json['category'] == null
        ? null
        : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
    status: json['status'] as String?,
    availability: json['availability'] as String?,
    videos: (json['videos'] as List<dynamic>?)
        ?.map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    photo: json['photo'] == null
        ? null
        : SourceModel.fromJson(json['photo'] as Map<String, dynamic>),
    membership: json['membership'] == null
        ? null
        : PartnerMemberModel.fromJson(
            json['membership'] as Map<String, dynamic>),
    subscription: json['subscription'] == null
        ? null
        : SubscriptionModel.fromJson(
            json['subscription'] as Map<String, dynamic>),
    photoId: json['photo.fileUUID'] as String?,
    id: json['id'] as int?,
    version: json['version'] as int?,
  );
}

Map<String, dynamic> _$PlayerModelToJson(PlayerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'fullNameAr': instance.tName,
      'name': instance.name,
      'legTitle': instance.tLeg,
      'leg': instance.legEn,
      'handTitle': instance.tHand,
      'hand': instance.handEn,
      'genderTitle': instance.tGender,
      'gender': instance.genderEn,
      'email': instance.email,
      'code': instance.code,
      'language': instance.language,
      'type': instance.type,
      'brief': instance.brief,
      'height': instance.height,
      'weight': instance.weight,
      'address': instance.address,
      'dateOfBirth': instance.dateOfBirth,
      'phone': instance.phone,
      'area': instance.area,
      'password': instance.password,
      'position': instance.position,
      'sport': instance.sport,
      'category': instance.category,
      'emirate': instance.emirate,
      'country': instance.country,
      'status': instance.status,
      'availability': instance.availability,
      'videos': instance.videos,
      'photo': instance.photo,
      'membership': instance.membership,
      'subscription': instance.subscription,
      'photo.fileUUID': instance.photoId,
    };
