// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_us_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactUsModel _$ContactUsModelFromJson(Map<String, dynamic> json) {
  return ContactUsModel(
    id: json['id'] as int,
    version: json['version'] as int,
    country: json['country'] as String,
    emirate: json['emirate'] as String,
    address: json['address'] as String,
    phone: json['phone'] as String,
    googleMapsCoordination: json['googleMapsCoordination'] as String,
    email: json['email'] as String,
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
      'googleMapsCoordination': instance.googleMapsCoordination,
      'email': instance.email,
    };
