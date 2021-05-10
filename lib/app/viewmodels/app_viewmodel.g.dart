// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppViewmodel on _AppViewmodelBase, Store {
  Computed<String>? _$languageComputed;

  @override
  String get language =>
      (_$languageComputed ??= Computed<String>(() => super.language,
              name: '_AppViewmodelBase.language'))
          .value;
  Computed<bool>? _$languageLoadingComputed;

  @override
  bool get languageLoading =>
      (_$languageLoadingComputed ??= Computed<bool>(() => super.languageLoading,
              name: '_AppViewmodelBase.languageLoading'))
          .value;

  final _$appBarParamsAtom = Atom(name: '_AppViewmodelBase.appBarParams');

  @override
  AppBarParams? get appBarParams {
    _$appBarParamsAtom.reportRead();
    return super.appBarParams;
  }

  @override
  set appBarParams(AppBarParams? value) {
    _$appBarParamsAtom.reportWrite(value, super.appBarParams, () {
      super.appBarParams = value;
    });
  }

  final _$pageIndexAtom = Atom(name: '_AppViewmodelBase.pageIndex');

  @override
  PageIndex get pageIndex {
    _$pageIndexAtom.reportRead();
    return super.pageIndex;
  }

  @override
  set pageIndex(PageIndex value) {
    _$pageIndexAtom.reportWrite(value, super.pageIndex, () {
      super.pageIndex = value;
    });
  }

  final _$languageFutureAtom = Atom(name: '_AppViewmodelBase.languageFuture');

  @override
  ObservableFuture<String>? get languageFuture {
    _$languageFutureAtom.reportRead();
    return super.languageFuture;
  }

  @override
  set languageFuture(ObservableFuture<String>? value) {
    _$languageFutureAtom.reportWrite(value, super.languageFuture, () {
      super.languageFuture = value;
    });
  }

  final _$deviceRegisteredAtom =
      Atom(name: '_AppViewmodelBase.deviceRegistered');

  @override
  bool get deviceRegistered {
    _$deviceRegisteredAtom.reportRead();
    return super.deviceRegistered;
  }

  @override
  set deviceRegistered(bool value) {
    _$deviceRegisteredAtom.reportWrite(value, super.deviceRegistered, () {
      super.deviceRegistered = value;
    });
  }

  final _$notificationsCountAtom =
      Atom(name: '_AppViewmodelBase.notificationsCount');

  @override
  int get notificationsCount {
    _$notificationsCountAtom.reportRead();
    return super.notificationsCount;
  }

  @override
  set notificationsCount(int value) {
    _$notificationsCountAtom.reportWrite(value, super.notificationsCount, () {
      super.notificationsCount = value;
    });
  }

  final _$userRegestedAtom = Atom(name: '_AppViewmodelBase.userRegested');

  @override
  bool? get userRegested {
    _$userRegestedAtom.reportRead();
    return super.userRegested;
  }

  @override
  set userRegested(bool? value) {
    _$userRegestedAtom.reportWrite(value, super.userRegested, () {
      super.userRegested = value;
    });
  }

  final _$registerDeviceAsyncAction =
      AsyncAction('_AppViewmodelBase.registerDevice');

  @override
  Future<void> registerDevice() {
    return _$registerDeviceAsyncAction.run(() => super.registerDevice());
  }

  final _$_AppViewmodelBaseActionController =
      ActionController(name: '_AppViewmodelBase');

  @override
  void init() {
    final _$actionInfo = _$_AppViewmodelBaseActionController.startAction(
        name: '_AppViewmodelBase.init');
    try {
      return super.init();
    } finally {
      _$_AppViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pushRoute(AppBarParams appBarParams) {
    final _$actionInfo = _$_AppViewmodelBaseActionController.startAction(
        name: '_AppViewmodelBase.pushRoute');
    try {
      return super.pushRoute(appBarParams);
    } finally {
      _$_AppViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void popRoute(BuildContext context, {VoidCallback? onBackPressed}) {
    final _$actionInfo = _$_AppViewmodelBaseActionController.startAction(
        name: '_AppViewmodelBase.popRoute');
    try {
      return super.popRoute(context, onBackPressed: onBackPressed);
    } finally {
      _$_AppViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void replaceAppBar(AppBarParams appBarParams) {
    final _$actionInfo = _$_AppViewmodelBaseActionController.startAction(
        name: '_AppViewmodelBase.replaceAppBar');
    try {
      return super.replaceAppBar(appBarParams);
    } finally {
      _$_AppViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void navigateTo(PageIndex newPageIndex) {
    final _$actionInfo = _$_AppViewmodelBaseActionController.startAction(
        name: '_AppViewmodelBase.navigateTo');
    try {
      return super.navigateTo(newPageIndex);
    } finally {
      _$_AppViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeLanguage(String? locale) {
    final _$actionInfo = _$_AppViewmodelBaseActionController.startAction(
        name: '_AppViewmodelBase.changeLanguage');
    try {
      return super.changeLanguage(locale);
    } finally {
      _$_AppViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateNotificationsCount() {
    final _$actionInfo = _$_AppViewmodelBaseActionController.startAction(
        name: '_AppViewmodelBase.updateNotificationsCount');
    try {
      return super.updateNotificationsCount();
    } finally {
      _$_AppViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleUserState({bool? status}) {
    final _$actionInfo = _$_AppViewmodelBaseActionController.startAction(
        name: '_AppViewmodelBase.toggleUserState');
    try {
      return super.toggleUserState(status: status);
    } finally {
      _$_AppViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void refreshUserStatus() {
    final _$actionInfo = _$_AppViewmodelBaseActionController.startAction(
        name: '_AppViewmodelBase.refreshUserStatus');
    try {
      return super.refreshUserStatus();
    } finally {
      _$_AppViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
appBarParams: ${appBarParams},
pageIndex: ${pageIndex},
languageFuture: ${languageFuture},
deviceRegistered: ${deviceRegistered},
notificationsCount: ${notificationsCount},
userRegested: ${userRegested},
language: ${language},
languageLoading: ${languageLoading}
    ''';
  }
}
