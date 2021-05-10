// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationsViewmodel on _NotificationsViewmodelBase, Store {
  Computed<ListBaseResponseModel<NotificationModel>?>? _$notificationsComputed;

  @override
  ListBaseResponseModel<NotificationModel>? get notifications =>
      (_$notificationsComputed ??=
              Computed<ListBaseResponseModel<NotificationModel>?>(
                  () => super.notifications,
                  name: '_NotificationsViewmodelBase.notifications'))
          .value;
  Computed<bool>? _$notificationsLoadingComputed;

  @override
  bool get notificationsLoading => (_$notificationsLoadingComputed ??=
          Computed<bool>(() => super.notificationsLoading,
              name: '_NotificationsViewmodelBase.notificationsLoading'))
      .value;
  Computed<bool>? _$notificationsErrorComputed;

  @override
  bool get notificationsError => (_$notificationsErrorComputed ??=
          Computed<bool>(() => super.notificationsError,
              name: '_NotificationsViewmodelBase.notificationsError'))
      .value;
  Computed<bool>? _$canLoadMoreNotificationsComputed;

  @override
  bool get canLoadMoreNotifications => (_$canLoadMoreNotificationsComputed ??=
          Computed<bool>(() => super.canLoadMoreNotifications,
              name: '_NotificationsViewmodelBase.canLoadMoreNotifications'))
      .value;

  final _$notificationsFutureAtom =
      Atom(name: '_NotificationsViewmodelBase.notificationsFuture');

  @override
  ObservableFuture<ListBaseResponseModel<NotificationModel>>?
      get notificationsFuture {
    _$notificationsFutureAtom.reportRead();
    return super.notificationsFuture;
  }

  @override
  set notificationsFuture(
      ObservableFuture<ListBaseResponseModel<NotificationModel>>? value) {
    _$notificationsFutureAtom.reportWrite(value, super.notificationsFuture, () {
      super.notificationsFuture = value;
    });
  }

  final _$_NotificationsViewmodelBaseActionController =
      ActionController(name: '_NotificationsViewmodelBase');

  @override
  void getnotifications({bool fresh = false}) {
    final _$actionInfo = _$_NotificationsViewmodelBaseActionController
        .startAction(name: '_NotificationsViewmodelBase.getnotifications');
    try {
      return super.getnotifications(fresh: fresh);
    } finally {
      _$_NotificationsViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
notificationsFuture: ${notificationsFuture},
notifications: ${notifications},
notificationsLoading: ${notificationsLoading},
notificationsError: ${notificationsError},
canLoadMoreNotifications: ${canLoadMoreNotifications}
    ''';
  }
}
