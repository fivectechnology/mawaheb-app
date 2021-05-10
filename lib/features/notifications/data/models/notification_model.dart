library notification_model;

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:mawaheb_app/base/data/models/version_model.dart';

part 'notification_model.g.dart';

enum NotificationType {
  PROFILE,
  ORDER,
  STORE,
  LOYALTY,
  UNKNOWN,
}

// static final String className = 'NotificationModel';
@JsonSerializable()
class NotificationModel extends VersionModel with EquatableMixin {
  const NotificationModel({
    required int? id,
    required int? version,
    required this.recordId,
    required this.template,
    required this.sendDate,
    required this.subject,
    required this.readDate,
    required this.type,
    required this.params,
    required this.message,
  }) : super(id, version);

  final int? recordId;
  final String? template;
  final String? sendDate;
  final String? subject;
  final String? readDate;
  @JsonKey(
    fromJson: NotificationTypeExtension.valueOf,
    toJson: NotificationTypeExtension.toRaw,
  )
  final NotificationType type;
  final String? params;
  final String? message;

  static NotificationModel fromJson(Object object) => _$NotificationModelFromJson(object as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  NotificationModel copyWith({
    int? id,
    int? version,
    int? recordId,
    String? template,
    String? sendDate,
    String? subject,
    String? readDate,
    String? type,
    String? params,
    String? message,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      version: version ?? this.version,
      recordId: recordId ?? this.recordId,
      template: template ?? this.template,
      sendDate: sendDate ?? this.sendDate,
      subject: subject ?? this.subject,
      readDate: readDate ?? this.readDate,
      type: type as NotificationType? ?? this.type,
      params: params ?? this.params,
      message: message ?? this.message,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      recordId,
      template,
      sendDate,
      subject,
      readDate,
      type,
      params,
      message,
    ];
  }
}

extension NotificationTypeExtension on NotificationType {
  String get raw => describeEnum(this);

  static NotificationType valueOf(String? data) {
    for (final NotificationType value in NotificationType.values) {
      if (value.raw == data) {
        return value;
      }
    }
    print('$data is not a valid NotificationType value');
    return NotificationType.UNKNOWN;
  }

  static String toRaw(NotificationType data) => data.raw;
}
