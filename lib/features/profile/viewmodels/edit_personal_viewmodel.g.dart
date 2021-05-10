// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_personal_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditPersonalViewmodel on _EditPersonalViewmodelBase, Store {
  Computed<List<CategoryModel>?>? _$categoriesComputed;

  @override
  List<CategoryModel>? get categories => (_$categoriesComputed ??=
          Computed<List<CategoryModel>?>(() => super.categories,
              name: '_EditPersonalViewmodelBase.categories'))
      .value;
  Computed<List<CountryModel>?>? _$countriesComputed;

  @override
  List<CountryModel>? get countries => (_$countriesComputed ??=
          Computed<List<CountryModel>?>(() => super.countries,
              name: '_EditPersonalViewmodelBase.countries'))
      .value;
  Computed<bool>? _$countryLoadingComputed;

  @override
  bool get countryLoading =>
      (_$countryLoadingComputed ??= Computed<bool>(() => super.countryLoading,
              name: '_EditPersonalViewmodelBase.countryLoading'))
          .value;
  Computed<bool>? _$categoryLoadingComputed;

  @override
  bool get categoryLoading =>
      (_$categoryLoadingComputed ??= Computed<bool>(() => super.categoryLoading,
              name: '_EditPersonalViewmodelBase.categoryLoading'))
          .value;
  Computed<bool>? _$personalLoadingComputed;

  @override
  bool get personalLoading =>
      (_$personalLoadingComputed ??= Computed<bool>(() => super.personalLoading,
              name: '_EditPersonalViewmodelBase.personalLoading'))
          .value;
  Computed<File?>? _$imageFileComputed;

  @override
  File? get imageFile =>
      (_$imageFileComputed ??= Computed<File?>(() => super.imageFile,
              name: '_EditPersonalViewmodelBase.imageFile'))
          .value;
  Computed<PlayerModel?>? _$playerComputed;

  @override
  PlayerModel? get player =>
      (_$playerComputed ??= Computed<PlayerModel?>(() => super.player,
              name: '_EditPersonalViewmodelBase.player'))
          .value;
  Computed<bool>? _$playerLoadingComputed;

  @override
  bool get playerLoading =>
      (_$playerLoadingComputed ??= Computed<bool>(() => super.playerLoading,
              name: '_EditPersonalViewmodelBase.playerLoading'))
          .value;

  final _$imageIdAtom = Atom(name: '_EditPersonalViewmodelBase.imageId');

  @override
  Future<int>? get imageId {
    _$imageIdAtom.reportRead();
    return super.imageId;
  }

  @override
  set imageId(Future<int>? value) {
    _$imageIdAtom.reportWrite(value, super.imageId, () {
      super.imageId = value;
    });
  }

  final _$imageAtom = Atom(name: '_EditPersonalViewmodelBase.image');

  @override
  File? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(File? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$playerFutureAtom =
      Atom(name: '_EditPersonalViewmodelBase.playerFuture');

  @override
  ObservableFuture<PlayerModel>? get playerFuture {
    _$playerFutureAtom.reportRead();
    return super.playerFuture;
  }

  @override
  set playerFuture(ObservableFuture<PlayerModel>? value) {
    _$playerFutureAtom.reportWrite(value, super.playerFuture, () {
      super.playerFuture = value;
    });
  }

  final _$editPersonalPlayerFutureAtom =
      Atom(name: '_EditPersonalViewmodelBase.editPersonalPlayerFuture');

  @override
  ObservableFuture<PlayerModel>? get editPersonalPlayerFuture {
    _$editPersonalPlayerFutureAtom.reportRead();
    return super.editPersonalPlayerFuture;
  }

  @override
  set editPersonalPlayerFuture(ObservableFuture<PlayerModel>? value) {
    _$editPersonalPlayerFutureAtom
        .reportWrite(value, super.editPersonalPlayerFuture, () {
      super.editPersonalPlayerFuture = value;
    });
  }

  final _$categoryFutureAtom =
      Atom(name: '_EditPersonalViewmodelBase.categoryFuture');

  @override
  ObservableFuture<List<CategoryModel>>? get categoryFuture {
    _$categoryFutureAtom.reportRead();
    return super.categoryFuture;
  }

  @override
  set categoryFuture(ObservableFuture<List<CategoryModel>>? value) {
    _$categoryFutureAtom.reportWrite(value, super.categoryFuture, () {
      super.categoryFuture = value;
    });
  }

  final _$countryFutureAtom =
      Atom(name: '_EditPersonalViewmodelBase.countryFuture');

  @override
  ObservableFuture<List<CountryModel>>? get countryFuture {
    _$countryFutureAtom.reportRead();
    return super.countryFuture;
  }

  @override
  set countryFuture(ObservableFuture<List<CountryModel>>? value) {
    _$countryFutureAtom.reportWrite(value, super.countryFuture, () {
      super.countryFuture = value;
    });
  }

  final _$_EditPersonalViewmodelBaseActionController =
      ActionController(name: '_EditPersonalViewmodelBase');

  @override
  void getCategories() {
    final _$actionInfo = _$_EditPersonalViewmodelBaseActionController
        .startAction(name: '_EditPersonalViewmodelBase.getCategories');
    try {
      return super.getCategories();
    } finally {
      _$_EditPersonalViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getCountries() {
    final _$actionInfo = _$_EditPersonalViewmodelBaseActionController
        .startAction(name: '_EditPersonalViewmodelBase.getCountries');
    try {
      return super.getCountries();
    } finally {
      _$_EditPersonalViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fetchPlayer({int? id}) {
    final _$actionInfo = _$_EditPersonalViewmodelBaseActionController
        .startAction(name: '_EditPersonalViewmodelBase.fetchPlayer');
    try {
      return super.fetchPlayer(id: id);
    } finally {
      _$_EditPersonalViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<int>? uploadImage(
      {int? playerId,
      int? playerVersion,
      File? file,
      int? fileSize,
      String? fileName,
      String? fileType}) {
    final _$actionInfo = _$_EditPersonalViewmodelBaseActionController
        .startAction(name: '_EditPersonalViewmodelBase.uploadImage');
    try {
      return super.uploadImage(
          playerId: playerId,
          playerVersion: playerVersion,
          file: file,
          fileSize: fileSize,
          fileName: fileName,
          fileType: fileType);
    } finally {
      _$_EditPersonalViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editPersonalInfo(
      {String? dateOfBirth,
      String? gender,
      String? name,
      String? phone,
      CountryModel? country,
      CategoryModel? categoryModel,
      int? id}) {
    final _$actionInfo = _$_EditPersonalViewmodelBaseActionController
        .startAction(name: '_EditPersonalViewmodelBase.editPersonalInfo');
    try {
      return super.editPersonalInfo(
          dateOfBirth: dateOfBirth,
          gender: gender,
          name: name,
          phone: phone,
          country: country,
          categoryModel: categoryModel,
          id: id);
    } finally {
      _$_EditPersonalViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
imageId: ${imageId},
image: ${image},
playerFuture: ${playerFuture},
editPersonalPlayerFuture: ${editPersonalPlayerFuture},
categoryFuture: ${categoryFuture},
countryFuture: ${countryFuture},
categories: ${categories},
countries: ${countries},
countryLoading: ${countryLoading},
categoryLoading: ${categoryLoading},
personalLoading: ${personalLoading},
imageFile: ${imageFile},
player: ${player},
playerLoading: ${playerLoading}
    ''';
  }
}
