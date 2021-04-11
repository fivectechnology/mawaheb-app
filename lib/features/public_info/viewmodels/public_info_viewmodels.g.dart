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
  Computed<ContactUsModel> _$contactsComputed;

  @override
  ContactUsModel get contacts =>
      (_$contactsComputed ??= Computed<ContactUsModel>(() => super.contacts,
              name: '_PublicInfoViewmodelBase.contacts'))
          .value;
  Computed<bool> _$contactsLoadingComputed;

  @override
  bool get contactsLoading =>
      (_$contactsLoadingComputed ??= Computed<bool>(() => super.contactsLoading,
              name: '_PublicInfoViewmodelBase.contactsLoading'))
          .value;
  Computed<bool> _$isLoggedComputed;

  @override
  bool get isLogged =>
      (_$isLoggedComputed ??= Computed<bool>(() => super.isLogged,
              name: '_PublicInfoViewmodelBase.isLogged'))
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

  final _$contactsFutureAtom =
      Atom(name: '_PublicInfoViewmodelBase.contactsFuture');

  @override
  ObservableFuture<ContactUsModel> get contactsFuture {
    _$contactsFutureAtom.reportRead();
    return super.contactsFuture;
  }

  @override
  set contactsFuture(ObservableFuture<ContactUsModel> value) {
    _$contactsFutureAtom.reportWrite(value, super.contactsFuture, () {
      super.contactsFuture = value;
    });
  }

  final _$isLoggedInAtom = Atom(name: '_PublicInfoViewmodelBase.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  final _$_PublicInfoViewmodelBaseActionController =
      ActionController(name: '_PublicInfoViewmodelBase');

  @override
  void userLoggedIn() {
    final _$actionInfo = _$_PublicInfoViewmodelBaseActionController.startAction(
        name: '_PublicInfoViewmodelBase.userLoggedIn');
    try {
      return super.userLoggedIn();
    } finally {
      _$_PublicInfoViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

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
  void getcontactUs() {
    final _$actionInfo = _$_PublicInfoViewmodelBaseActionController.startAction(
        name: '_PublicInfoViewmodelBase.getcontactUs');
    try {
      return super.getcontactUs();
    } finally {
      _$_PublicInfoViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
aboutUsFuture: ${aboutUsFuture},
contactsFuture: ${contactsFuture},
isLoggedIn: ${isLoggedIn},
aboutUs: ${aboutUs},
aboutUsLoading: ${aboutUsLoading},
contacts: ${contacts},
contactsLoading: ${contactsLoading},
isLogged: ${isLogged}
    ''';
  }
}
