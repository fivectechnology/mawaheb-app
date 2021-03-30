import 'package:core_sdk/data/repositories/base_repository.dart';
import 'package:mawaheb_app/features/notifications/data/datasources/notifications_datasource.dart';

abstract class NotificationsRepository extends BaseRepository {
  const NotificationsRepository(NotificationsDataSource notificationsDataSource) : super(notificationsDataSource);
}
