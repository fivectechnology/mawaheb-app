import 'package:core_sdk/utils/network_result.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/features/notifications/data/datasources/notifications_datasource.dart';
import 'package:mawaheb_app/features/notifications/data/models/notification_model.dart';
import 'package:mawaheb_app/features/notifications/domain/repositories/notifications_repository.dart';

@LazySingleton(as: NotificationsRepository)
class NotificationsRepositoryImpl extends NotificationsRepository {
  const NotificationsRepositoryImpl(this.notificationsDataSource) : super(notificationsDataSource);
  final NotificationsDataSource notificationsDataSource;

  @override
  Future<NetworkResult<ListBaseResponseModel<NotificationModel>>> getNotifications() =>
      notificationsDataSource.getNotifications();

  @override
  Future<NetworkResult<BaseResponseModel<Object>>> markAsRead({int notificationId}) =>
      notificationsDataSource.markAsRead(notificationId: notificationId);
}
