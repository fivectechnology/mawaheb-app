import 'package:core_sdk/data/viewmodels/base_viewmodel.dart';
import 'package:core_sdk/utils/Fimber/Logger.dart';
import 'package:core_sdk/utils/extensions/mobx.dart';
import 'package:injectable/injectable.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/features/notifications/data/models/notification_model.dart';
import 'package:mawaheb_app/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:supercharged/supercharged.dart';

part 'notifications_viewmodel.g.dart';

@injectable
class NotificationsViewmodel extends _NotificationsViewmodelBase
    with _$NotificationsViewmodel {
  NotificationsViewmodel(
    Logger logger,
    NotificationsRepository notificationsRepository,
  ) : super(logger, notificationsRepository);
}

abstract class _NotificationsViewmodelBase extends BaseViewmodel with Store {
  _NotificationsViewmodelBase(Logger logger, this._notificationsRepository)
      : super(logger);
  final NotificationsRepository _notificationsRepository;

  //* OBSERVERS *//

  @observable
  ObservableFuture<ListBaseResponseModel<NotificationModel>>?
      notificationsFuture;

  //* COMPUTED *//

  @computed
  ListBaseResponseModel<NotificationModel>? get notifications =>
      notificationsFuture?.value;

  @computed
  bool get notificationsLoading => notificationsFuture?.isPending ?? false;

  @computed
  bool get notificationsError => notificationsFuture?.isFailure ?? false;

  @computed
  bool get canLoadMoreNotifications {
    if (notifications == null) {
      return true;
    }
    if (notifications!.offset! + PAGE_SIZE < notifications!.total!) {
      return true;
    }

    return false;
  }

  //* ACTIONS *//

  @action
  void getnotifications({bool fresh = false}) {
    if (fresh || canLoadMoreNotifications) {
      int offset = (notifications?.offset ?? -PAGE_SIZE) + PAGE_SIZE;
      if (fresh) {
        notificationsFuture = null;
        offset = 0;
      }

      final ObservableFuture<ListBaseResponseModel<NotificationModel>> future =
          futureWrapper(
        () => _notificationsRepository
            .getNotifications(limit: PAGE_SIZE, offset: offset)
            .replace(
              oldValue: notificationsFuture,
              onSuccess: () {},
            ),
        catchBlock: (err) => showSnack(err!, duration: 2.seconds),
        unknownErrorHandler: (err) => showSnack(err, duration: 2.seconds),
      );
      notificationsFuture = notificationsFuture?.replace(future) ?? future;
    }
  }
}
