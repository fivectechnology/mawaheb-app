import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:core_sdk/utils/network_result.dart';
import 'package:mawaheb_app/base/data/models/base_response_model.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/features/notifications/data/datasources/notifications_datasource.dart';
import 'package:mawaheb_app/features/notifications/data/models/notification_model.dart';

abstract class NotificationsRepository extends BaseRepository {
  const NotificationsRepository(NotificationsDataSource notificationsDataSource) : super(notificationsDataSource);

  Future<NetworkResult<ListBaseResponseModel<NotificationModel>>> getNotifications();

  Future<NetworkResult<BaseResponseModel<Object>>> markAsRead({int notificationId});
}
