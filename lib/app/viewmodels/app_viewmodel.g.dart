// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppViewmodel on _AppViewmodelBase, Store {
  final _$appBarParamsAtom = Atom(name: '_AppViewmodelBase.appBarParams');

  @override
  AppBarParams get appBarParams {
    _$appBarParamsAtom.reportRead();
    return super.appBarParams;
  }

  @override
  set appBarParams(AppBarParams value) {
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

  final _$_AppViewmodelBaseActionController =
      ActionController(name: '_AppViewmodelBase');

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
  void popRoute(BuildContext context, {VoidCallback onBackPressed}) {
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
  String toString() {
    return '''
appBarParams: ${appBarParams},
pageIndex: ${pageIndex}
    ''';
  }
}
