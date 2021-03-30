import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/features/notifications/data/datasources/notifications_datasource.dart';
import 'package:mawaheb_app/features/notifications/domain/repositories/notifications_repository.dart';

@LazySingleton(as: NotificationsRepository)
class NotificationsRepositoryImpl extends NotificationsRepository {
  const NotificationsRepositoryImpl(this.notificationsDataSource) : super(notificationsDataSource);
  final NotificationsDataSource notificationsDataSource;
}
