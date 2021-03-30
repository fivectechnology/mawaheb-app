import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:mobx/mobx.dart';

part 'notifications_viewmodel.g.dart';

@injectable
class NotificationsViewmodel extends _NotificationsViewmodelBase with _$NotificationsViewmodel {
  NotificationsViewmodel(
    Logger logger,
    NotificationsRepository notificationsRepository,
  ) : super(logger, notificationsRepository);
}

abstract class _NotificationsViewmodelBase extends BaseViewmodel with Store {
  _NotificationsViewmodelBase(Logger logger, this._notificationsRepository) : super(logger);
  final NotificationsRepository _notificationsRepository;

  //* OBSERVERS *//

  //* COMPUTED *//

  //* ACTIONS *//

}
