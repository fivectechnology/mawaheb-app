// GENERATED CODE - DO NOT MODIFY BY HAND

part of notification_model;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return NotificationModel(
    id: json['id'] as int?,
    version: json['version'] as int?,
    recordId: json['recordId'] as int?,
    template: json['template'] as String?,
    sendDate: json['sendDate'] as String?,
    subject: json['subject'] as String?,
    readDate: json['readDate'] as String?,
    type: NotificationTypeExtension.valueOf(json['type'] as String?),
    params: json['params'] as String?,
    message: json['message'] as String?,
  );
}

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'version': instance.version,
      'recordId': instance.recordId,
      'template': instance.template,
      'sendDate': instance.sendDate,
      'subject': instance.subject,
      'readDate': instance.readDate,
      'type': NotificationTypeExtension.toRaw(instance.type),
      'params': instance.params,
      'message': instance.message,
    };
