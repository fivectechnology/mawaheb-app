import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel extends VersionModel with EquatableMixin {
  const CategoryModel({
    @required this.title,
    @required this.tName,
    @required int id,
    @required int version,
  }) : super(id, version);

  @JsonKey(name: r'$t:name')
  final String tName;
  final String title;

  CategoryModel copyWith({
    String title,
    String tName,
    int id,
    int version,
  }) {
    return CategoryModel(
      title: title ?? this.title,
      tName: tName ?? this.tName,
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
      tName,
      id,
      version,
    ];
  }

  static CategoryModel fromJson(Object json) => _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
