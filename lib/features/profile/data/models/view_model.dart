import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';
import 'package:mawaheb_app/features/profile/data/models/partner_model.dart';
import 'package:mawaheb_app/features/public_info/data/models/source_model.dart';

part 'view_model.g.dart';

@JsonSerializable()
class ViewModel extends VersionModel with EquatableMixin {
  const ViewModel({
    @required this.partner,
    @required this.partnerPhoto,
    @required this.type,
    @required int id,
    @required int version,
  }) : super(id, version);

  final PartnerModel partner;
  @JsonKey(name: 'partner.photo')
  final SourceModel partnerPhoto;

  @JsonKey(name: 'partner.type')
  final String type;

  ViewModel copyWith({
    PartnerModel partner,
    int id,
    int version,
    SourceModel partnerPhoto,
    String type,
  }) {
    return ViewModel(
      partnerPhoto: partnerPhoto ?? this.partnerPhoto,
      partner: partner ?? this.partner,
      type: type ?? this.type,
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      partner,
      id,
      version,
      type,
      partnerPhoto,
    ];
  }

  static ViewModel fromJson(Object json) => _$ViewModelFromJson(json);
  Map<String, dynamic> toJson() => _$ViewModelToJson(this);
}
