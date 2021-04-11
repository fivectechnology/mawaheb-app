// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthViewmodel on _AuthViewmodelBase, Store {
  Computed<bool> _$loginLoadingComputed;

  @override
  bool get loginLoading =>
      (_$loginLoadingComputed ??= Computed<bool>(() => super.loginLoading,
              name: '_AuthViewmodelBase.loginLoading'))
          .value;
  Computed<bool> _$loginErrorComputed;

  @override
  bool get loginError =>
      (_$loginErrorComputed ??= Computed<bool>(() => super.loginError,
              name: '_AuthViewmodelBase.loginError'))
          .value;

  final _$loginFutureAtom = Atom(name: '_AuthViewmodelBase.loginFuture');

  @override
  ObservableFuture<bool> get loginFuture {
    _$loginFutureAtom.reportRead();
    return super.loginFuture;
  }

  @override
  set loginFuture(ObservableFuture<bool> value) {
    _$loginFutureAtom.reportWrite(value, super.loginFuture, () {
      super.loginFuture = value;
    });
  }

  final _$_AuthViewmodelBaseActionController =
      ActionController(name: '_AuthViewmodelBase');

  @override
  void login({String userName, String password}) {
    final _$actionInfo = _$_AuthViewmodelBaseActionController.startAction(
        name: '_AuthViewmodelBase.login');
    try {
      return super.login(userName: userName, password: password);
    } finally {
      _$_AuthViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loginFuture: ${loginFuture},
loginLoading: ${loginLoading},
loginError: ${loginError}
    ''';
  }
}
