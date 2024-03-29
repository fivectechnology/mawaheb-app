// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_us_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactUsModel _$ContactUsModelFromJson(Map<String, dynamic> json) {
  return ContactUsModel(
    id: json['id'] as int?,
    version: json['version'] as int?,
    country: json['country'] == null
        ? null
        : CountryModel.fromJson(json['country'] as Map<String, dynamic>),
    emirate: json['emirate'] == null
        ? null
        : EmirateModel.fromJson(json['emirate'] as Map<String, dynamic>),
    address: json['address'] as String?,
    phone: json['phone'] as String?,
    latitude: json['latitude'] as String?,
    longitude: json['longitude'] as String?,
    email: json['email'] as String?,
    addressAr: json['addressAr'] as String?,
  );
}

Map<String, dynamic> _$ContactUsModelToJson(ContactUsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'country': instance.country,
      'emirate': instance.emirate,
      'address': instance.address,
      'phone': instance.phone,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'addressAr': instance.addressAr,
      'email': instance.email,
    };
