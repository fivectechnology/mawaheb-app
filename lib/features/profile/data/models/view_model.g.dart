// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViewModel _$ViewModelFromJson(Map<String, dynamic> json) {
  return ViewModel(
    partner: json['partner'] == null
        ? null
        : PartnerModel.fromJson(json['partner'] as Map<String, dynamic>),
    id: json['id'] as int,
    version: json['version'] as int,
  );
}

Map<String, dynamic> _$ViewModelToJson(ViewModel instance) => <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'partner': instance.partner,
    };
