import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel with EquatableMixin {
  const CategoryModel({
    required this.titleEn,
    required this.tTitle,
    required this.id,
  });

  @JsonKey(name: r'$t:title')
  final String? tTitle;
  @JsonKey(name: 'title')
  final String? titleEn;

  final int? id;

  CategoryModel copyWith({
    String? titleEn,
    String? tTitle,
    int? id,
  }) {
    return CategoryModel(
      titleEn: titleEn ?? this.titleEn,
      tTitle: tTitle ?? this.tTitle,
      id: id ?? this.id,
    );
  }

  @override
  bool get stringify => true;

  String? get title => tTitle ?? titleEn;

  @override
  List<Object?> get props {
    return [
      titleEn,
      tTitle,
      id,
    ];
  }

  static CategoryModel fromJson(Object json) => _$CategoryModelFromJson(json as Map<String, dynamic>);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
