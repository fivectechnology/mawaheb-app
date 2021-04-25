library notification_model;

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

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
class NotificationModel {
  const NotificationModel(
    this.userId,
    this.createdBy,
    this.updatedBy,
    this.messageId,
    this.recordId,
    this.subject,
    this.message,
    this.typeCode,
    this.params,
    this.notificationCode,
    this.sendDate,
    this.readDate,
    this.createdAt,
    this.updatedAt,
  );

  final int userId;
  final int createdBy;
  final int updatedBy;
  final int messageId;
  final int recordId;
  final String subject;
  final String message;
  @JsonKey(
    fromJson: NotificationTypeExtension.valueOf,
    toJson: NotificationTypeExtension.toRaw,
  )
  final NotificationType typeCode;
  final String params;
  final String notificationCode;
  final String sendDate;
  final String readDate;
  final String createdAt;
  final String updatedAt;

  NotificationModel copyWith({String readDate}) => NotificationModel(
        userId,
        createdBy,
        updatedBy,
        messageId,
        recordId,
        subject,
        message,
        typeCode,
        params,
        notificationCode,
        sendDate,
        readDate,
        createdAt,
        updatedAt,
      );

  static NotificationModel fromJson(Object object) => _$NotificationModelFromJson(object);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

extension NotificationTypeExtension on NotificationType {
  String get raw => describeEnum(this);

  static NotificationType valueOf(String data) {
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
