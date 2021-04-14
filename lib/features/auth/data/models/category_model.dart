import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel extends VersionModel with EquatableMixin {
  const CategoryModel({
    @required this.title,
    @required int id,
    @required int version,
  }) : super(id, version);

  final String title;

  CategoryModel copyWith({
    String title,
    int id,
    int version,
  }) {
    return CategoryModel(
      title: title ?? this.title,
      id: id ?? this.id,
      version: version ?? this.version,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      title,
      id,
      version,
    ];
  }

  static CategoryModel fromJson(Object json) => _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
