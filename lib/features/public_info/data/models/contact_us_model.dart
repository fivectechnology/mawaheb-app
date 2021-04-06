import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'contact_us_model.g.dart';

@JsonSerializable()
class ContactUsModel extends VersionModel with EquatableMixin {
  const ContactUsModel({
    @required int id,
    @required int version,
    @required this.country,
    @required this.emirate,
    @required this.address,
    @required this.phone,
    @required this.googleMapsCoordination,
    @required this.email,
  }) : super(id, version);

  final String country;
  final String emirate;
  final String address;
  final String phone;
  final String googleMapsCoordination;
  final String email;

  ContactUsModel copyWith({
    int id,
    int version,
    String country,
    String emirate,
    String address,
    String phone,
    String googleMapsCoordination,
    String email,
  }) {
    return ContactUsModel(
      id: id ?? this.id,
      version: version ?? this.version,
      country: country ?? this.country,
      emirate: emirate ?? this.emirate,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      googleMapsCoordination: googleMapsCoordination ?? this.googleMapsCoordination,
      email: email ?? this.email,
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
      googleMapsCoordination,
      email,
    ];
  }

  static ContactUsModel fromJson(Object json) => _$ContactUsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContactUsModelToJson(this);
}
