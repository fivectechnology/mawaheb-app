import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'subscription_model.g.dart';

@JsonSerializable()
class SubscriptionModel extends VersionModel with EquatableMixin {
  const SubscriptionModel({
    @required this.startedAt,
    @required this.finishAt,
    @required this.name,
    @required this.amount,
    @required this.period,
    @required this.active,
    @required int id,
    @required int version,
  }) : super(id, version);

  final String finishAt;
  final String startedAt;
  final String name;
  final int amount;
  final int period;
  final bool active;

  SubscriptionModel copyWith({
    String startedAt,
    String finishAt,
    String name,
    int amount,
    int period,
    bool active,
    int id,
    int version,
  }) {
    return SubscriptionModel(
      finishAt: finishAt ?? this.finishAt,
      startedAt: startedAt ?? this.startedAt,
      active: active ?? this.active,
      amount: amount ?? this.amount,
      period: period ?? this.period,
      name: name ?? this.name,
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      startedAt,
      finishAt,
      name,
      period,
      amount,
      active,
      id,
      version,
    ];
  }

  static SubscriptionModel fromJson(Object json) =>
      _$SubscriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionModelToJson(this);
}
