// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionModel _$SubscriptionModelFromJson(Map<String, dynamic> json) {
  return SubscriptionModel(
    startedAt: json['startedAt'] as String?,
    finishAt: json['finishAt'] as String?,
    name: json['name'] as String?,
    amount: json['amount'] as int?,
    period: json['period'] as int?,
    active: json['active'] as bool?,
    id: json['id'] as int?,
    version: json['version'] as int?,
  );
}

Map<String, dynamic> _$SubscriptionModelToJson(SubscriptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'finishAt': instance.finishAt,
      'startedAt': instance.startedAt,
      'name': instance.name,
      'amount': instance.amount,
      'period': instance.period,
      'active': instance.active,
    };
