import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:mawaheb_app/base/data/models/version_model.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/data/models/emirate_model.dart';

part 'contact_us_model.g.dart';

@JsonSerializable()
class ContactUsModel extends VersionModel with EquatableMixin {
  const ContactUsModel(
      {@required int id,
      @required int version,
      @required this.country,
      @required this.emirate,
      @required this.address,
      @required this.phone,
      @required this.latitude,
      @required this.longitude,
      @required this.email,
      @required this.addressAr})
      : super(id, version);

  final CountryModel country;
  final EmirateModel emirate;
  final String address;
  final String phone;
  final String longitude;
  final String latitude;
  final String addressAr;
  final String email;

  ContactUsModel copyWith(
      {int id,
      int version,
      CountryModel country,
      EmirateModel emirate,
      String address,
      String phone,
      String googleMapsCoordination,
      String email,
      String longitude,
      String addressAr,
      String latitude}) {
    return ContactUsModel(
      id: id ?? this.id,
      version: version ?? this.version,
      country: country ?? this.country,
      emirate: emirate ?? this.emirate,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      email: email ?? this.email,
      addressAr: addressAr ?? this.addressAr,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      country,
      emirate,
      address,
      phone,
      longitude,
      latitude,
      email,
      addressAr
    ];
  }

  static ContactUsModel fromJson(Object json) => _$ContactUsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContactUsModelToJson(this);
}
