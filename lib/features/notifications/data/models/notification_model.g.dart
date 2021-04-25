// GENERATED CODE - DO NOT MODIFY BY HAND

part of notification_model;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return NotificationModel(
    json['userId'] as int,
    json['createdBy'] as int,
    json['updatedBy'] as int,
    json['messageId'] as int,
    json['recordId'] as int,
    json['subject'] as String,
    json['message'] as String,
    NotificationTypeExtension.valueOf(json['typeCode'] as String),
    json['params'] as String,
    json['notificationCode'] as String,
    json['sendDate'] as String,
    json['readDate'] as String,
    json['createdAt'] as String,
    json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'messageId': instance.messageId,
      'recordId': instance.recordId,
      'subject': instance.subject,
      'message': instance.message,
      'typeCode': NotificationTypeExtension.toRaw(instance.typeCode),
      'params': instance.params,
      'notificationCode': instance.notificationCode,
      'sendDate': instance.sendDate,
      'readDate': instance.readDate,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
