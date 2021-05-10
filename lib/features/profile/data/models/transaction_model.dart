import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel extends VersionModel with EquatableMixin {
  const TransactionModel({
    required this.amount,
    required int? id,
    required int? version,
  }) : super(id, version);

  final int? amount;

  TransactionModel copyWith({
    int? amount,
    int? id,
    int? version,
  }) {
    return TransactionModel(
      amount: amount ?? this.amount,
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      amount,
      id,
      version,
    ];
  }

  static TransactionModel fromJson(Object json) =>
      _$TransactionModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
