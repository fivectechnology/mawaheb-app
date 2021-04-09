// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_info_viewmodels.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PublicInfoViewmodel on _PublicInfoViewmodelBase, Store {
  Computed<AboutUsModel> _$aboutUsComputed;

  @override
  AboutUsModel get aboutUs =>
      (_$aboutUsComputed ??= Computed<AboutUsModel>(() => super.aboutUs,
              name: '_PublicInfoViewmodelBase.aboutUs'))
          .value;
  Computed<bool> _$aboutUsLoadingComputed;

  @override
  bool get aboutUsLoading =>
      (_$aboutUsLoadingComputed ??= Computed<bool>(() => super.aboutUsLoading,
              name: '_PublicInfoViewmodelBase.aboutUsLoading'))
          .value;

  final _$aboutUsFutureAtom =
      Atom(name: '_PublicInfoViewmodelBase.aboutUsFuture');

  @override
  ObservableFuture<AboutUsModel> get aboutUsFuture {
    _$aboutUsFutureAtom.reportRead();
    return super.aboutUsFuture;
  }

  @override
  set aboutUsFuture(ObservableFuture<AboutUsModel> value) {
    _$aboutUsFutureAtom.reportWrite(value, super.aboutUsFuture, () {
      super.aboutUsFuture = value;
    });
  }

  final _$_PublicInfoViewmodelBaseActionController =
      ActionController(name: '_PublicInfoViewmodelBase');

  @override
  void getaboutUs() {
    final _$actionInfo = _$_PublicInfoViewmodelBaseActionController.startAction(
        name: '_PublicInfoViewmodelBase.getaboutUs');
    try {
      return super.getaboutUs();
    } finally {
      _$_PublicInfoViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
aboutUsFuture: ${aboutUsFuture},
aboutUs: ${aboutUs},
aboutUsLoading: ${aboutUsLoading}
    ''';
  }
}
