import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel extends VersionModel with EquatableMixin {
  const CategoryModel({
    @required this.titleEn,
    @required this.tTitle,
    @required int id,
    @required int version,
  }) : super(id, version);

  @JsonKey(name: r'$t:title')
  final String tTitle;
  @JsonKey(name: 'title')
  final String titleEn;

  CategoryModel copyWith({
    String titleEn,
    String tTitle,
    int id,
    int version,
  }) {
    return CategoryModel(
      titleEn: titleEn ?? this.titleEn,
      tTitle: tTitle ?? this.tTitle,
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  String get title => tTitle ?? titleEn;

  @override
  List<Object> get props {
    return [
      titleEn,
      tTitle,
      id,
      version,
    ];
  }

  static CategoryModel fromJson(Object json) => _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
