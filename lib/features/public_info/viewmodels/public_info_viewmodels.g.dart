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
  Computed<ContactUsModel> _$galleryComputed;

  @override
  ContactUsModel get gallery =>
      (_$galleryComputed ??= Computed<ContactUsModel>(() => super.gallery,
              name: '_PublicInfoViewmodelBase.gallery'))
          .value;
  Computed<bool> _$galleryLoadingComputed;

  @override
  bool get galleryLoading =>
      (_$galleryLoadingComputed ??= Computed<bool>(() => super.galleryLoading,
              name: '_PublicInfoViewmodelBase.galleryLoading'))
          .value;
  Computed<ContactUsModel> _$partnersComputed;

  @override
  ContactUsModel get partners =>
      (_$partnersComputed ??= Computed<ContactUsModel>(() => super.partners,
              name: '_PublicInfoViewmodelBase.partners'))
          .value;
  Computed<bool> _$partnersLoadingComputed;

  @override
  bool get partnersLoading =>
      (_$partnersLoadingComputed ??= Computed<bool>(() => super.partnersLoading,
              name: '_PublicInfoViewmodelBase.partnersLoading'))
          .value;
  Computed<ContactUsModel> _$downloadsComputed;

  @override
  ContactUsModel get downloads =>
      (_$downloadsComputed ??= Computed<ContactUsModel>(() => super.downloads,
              name: '_PublicInfoViewmodelBase.downloads'))
          .value;
  Computed<bool> _$downloadsLoadingComputed;

  @override
  bool get downloadsLoading => (_$downloadsLoadingComputed ??= Computed<bool>(
          () => super.downloadsLoading,
          name: '_PublicInfoViewmodelBase.downloadsLoading'))
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

  final _$galleryFutureAtom =
      Atom(name: '_PublicInfoViewmodelBase.galleryFuture');

  @override
  ObservableFuture<GalleryModel> get galleryFuture {
    _$galleryFutureAtom.reportRead();
    return super.galleryFuture;
  }

  @override
  set galleryFuture(ObservableFuture<GalleryModel> value) {
    _$galleryFutureAtom.reportWrite(value, super.galleryFuture, () {
      super.galleryFuture = value;
    });
  }

  final _$partnersFutureAtom =
      Atom(name: '_PublicInfoViewmodelBase.partnersFuture');

  @override
  ObservableFuture<StrategicPartnersModel> get partnersFuture {
    _$partnersFutureAtom.reportRead();
    return super.partnersFuture;
  }

  @override
  set partnersFuture(ObservableFuture<StrategicPartnersModel> value) {
    _$partnersFutureAtom.reportWrite(value, super.partnersFuture, () {
      super.partnersFuture = value;
    });
  }

  final _$downloadsFutureAtom =
      Atom(name: '_PublicInfoViewmodelBase.downloadsFuture');

  @override
  ObservableFuture<DownloadCenterModel> get downloadsFuture {
    _$downloadsFutureAtom.reportRead();
    return super.downloadsFuture;
  }

  @override
  set downloadsFuture(ObservableFuture<DownloadCenterModel> value) {
    _$downloadsFutureAtom.reportWrite(value, super.downloadsFuture, () {
      super.downloadsFuture = value;
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
galleryFuture: ${galleryFuture},
partnersFuture: ${partnersFuture},
downloadsFuture: ${downloadsFuture},
isLoggedIn: ${isLoggedIn},
aboutUs: ${aboutUs},
aboutUsLoading: ${aboutUsLoading},
contacts: ${contacts},
contactsLoading: ${contactsLoading},
gallery: ${gallery},
galleryLoading: ${galleryLoading},
partners: ${partners},
partnersLoading: ${partnersLoading},
downloads: ${downloads},
downloadsLoading: ${downloadsLoading},
isLogged: ${isLogged}
    ''';
  }
}
