// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SplashViewmodel on _SplashViewmodelBase, Store {
  Computed<bool>? _$logoutLoadingComputed;

  @override
  bool get logoutLoading =>
      (_$logoutLoadingComputed ??= Computed<bool>(() => super.logoutLoading,
              name: '_SplashViewmodelBase.logoutLoading'))
          .value;

  final _$logoutFutureAtom = Atom(name: '_SplashViewmodelBase.logoutFuture');

  @override
  ObservableFuture<bool>? get logoutFuture {
    _$logoutFutureAtom.reportRead();
    return super.logoutFuture;
  }

  @override
  set logoutFuture(ObservableFuture<bool>? value) {
    _$logoutFutureAtom.reportWrite(value, super.logoutFuture, () {
      super.logoutFuture = value;
    });
  }

  final _$_SplashViewmodelBaseActionController =
      ActionController(name: '_SplashViewmodelBase');

  @override
  void logout() {
    final _$actionInfo = _$_SplashViewmodelBaseActionController.startAction(
        name: '_SplashViewmodelBase.logout');
    try {
      return super.logout();
    } finally {
      _$_SplashViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
logoutFuture: ${logoutFuture},
logoutLoading: ${logoutLoading}
    ''';
  }
}
