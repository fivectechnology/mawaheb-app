// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileViewmodel on _ProfileViewmodelBase, Store {
  Computed<PlayerModel> _$playerComputed;

  @override
  PlayerModel get player =>
      (_$playerComputed ??= Computed<PlayerModel>(() => super.player,
              name: '_ProfileViewmodelBase.player'))
          .value;
  Computed<bool> _$playerLoadingComputed;

  @override
  bool get playerLoading =>
      (_$playerLoadingComputed ??= Computed<bool>(() => super.playerLoading,
              name: '_ProfileViewmodelBase.playerLoading'))
          .value;
  Computed<List<CategoryModel>> _$categoriesComputed;

  @override
  List<CategoryModel> get categories => (_$categoriesComputed ??=
          Computed<List<CategoryModel>>(() => super.categories,
              name: '_ProfileViewmodelBase.categories'))
      .value;
  Computed<List<SportModel>> _$sportsComputed;

  @override
  List<SportModel> get sports =>
      (_$sportsComputed ??= Computed<List<SportModel>>(() => super.sports,
              name: '_ProfileViewmodelBase.sports'))
          .value;
  Computed<List<CountryModel>> _$countriesComputed;

  @override
  List<CountryModel> get countries => (_$countriesComputed ??=
          Computed<List<CountryModel>>(() => super.countries,
              name: '_ProfileViewmodelBase.countries'))
      .value;
  Computed<List<SportPositionModel>> _$positionsComputed;

  @override
  List<SportPositionModel> get positions => (_$positionsComputed ??=
          Computed<List<SportPositionModel>>(() => super.positions,
              name: '_ProfileViewmodelBase.positions'))
      .value;
  Computed<List<EmirateModel>> _$emiratesComputed;

  @override
  List<EmirateModel> get emirates =>
      (_$emiratesComputed ??= Computed<List<EmirateModel>>(() => super.emirates,
              name: '_ProfileViewmodelBase.emirates'))
          .value;
  Computed<List<ViewModel>> _$viewsComputed;

  @override
  List<ViewModel> get views =>
      (_$viewsComputed ??= Computed<List<ViewModel>>(() => super.views,
              name: '_ProfileViewmodelBase.views'))
          .value;
  Computed<bool> _$deleteVideoLoadingComputed;

  @override
  bool get deleteVideoLoading => (_$deleteVideoLoadingComputed ??=
          Computed<bool>(() => super.deleteVideoLoading,
              name: '_ProfileViewmodelBase.deleteVideoLoading'))
      .value;
  Computed<bool> _$deleteVideoErrorComputed;

  @override
  bool get deleteVideoError => (_$deleteVideoErrorComputed ??= Computed<bool>(
          () => super.deleteVideoError,
          name: '_ProfileViewmodelBase.deleteVideoError'))
      .value;
  Computed<bool> _$replaceVideoLoadingComputed;

  @override
  bool get replaceVideoLoading => (_$replaceVideoLoadingComputed ??=
          Computed<bool>(() => super.replaceVideoLoading,
              name: '_ProfileViewmodelBase.replaceVideoLoading'))
      .value;
  Computed<bool> _$replaceVideoErrorComputed;

  @override
  bool get replaceVideoError => (_$replaceVideoErrorComputed ??= Computed<bool>(
          () => super.replaceVideoError,
          name: '_ProfileViewmodelBase.replaceVideoError'))
      .value;
  Computed<File> _$imageFileComputed;

  @override
  File get imageFile =>
      (_$imageFileComputed ??= Computed<File>(() => super.imageFile,
              name: '_ProfileViewmodelBase.imageFile'))
          .value;

  final _$imageAtom = Atom(name: '_ProfileViewmodelBase.image');

  @override
  File get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(File value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$imageIdAtom = Atom(name: '_ProfileViewmodelBase.imageId');

  @override
  Future<int> get imageId {
    _$imageIdAtom.reportRead();
    return super.imageId;
  }

  @override
  set imageId(Future<int> value) {
    _$imageIdAtom.reportWrite(value, super.imageId, () {
      super.imageId = value;
    });
  }

  final _$playerFutureAtom = Atom(name: '_ProfileViewmodelBase.playerFuture');

  @override
  ObservableFuture<PlayerModel> get playerFuture {
    _$playerFutureAtom.reportRead();
    return super.playerFuture;
  }

  @override
  set playerFuture(ObservableFuture<PlayerModel> value) {
    _$playerFutureAtom.reportWrite(value, super.playerFuture, () {
      super.playerFuture = value;
    });
  }

  final _$editAddressPlayerFutureAtom =
      Atom(name: '_ProfileViewmodelBase.editAddressPlayerFuture');

  @override
  ObservableFuture<PlayerModel> get editAddressPlayerFuture {
    _$editAddressPlayerFutureAtom.reportRead();
    return super.editAddressPlayerFuture;
  }

  @override
  set editAddressPlayerFuture(ObservableFuture<PlayerModel> value) {
    _$editAddressPlayerFutureAtom
        .reportWrite(value, super.editAddressPlayerFuture, () {
      super.editAddressPlayerFuture = value;
    });
  }

  final _$editPersonalPlayerFutureAtom =
      Atom(name: '_ProfileViewmodelBase.editPersonalPlayerFuture');

  @override
  ObservableFuture<PlayerModel> get editPersonalPlayerFuture {
    _$editPersonalPlayerFutureAtom.reportRead();
    return super.editPersonalPlayerFuture;
  }

  @override
  set editPersonalPlayerFuture(ObservableFuture<PlayerModel> value) {
    _$editPersonalPlayerFutureAtom
        .reportWrite(value, super.editPersonalPlayerFuture, () {
      super.editPersonalPlayerFuture = value;
    });
  }

  final _$editSportPlayerFutureAtom =
      Atom(name: '_ProfileViewmodelBase.editSportPlayerFuture');

  @override
  ObservableFuture<PlayerModel> get editSportPlayerFuture {
    _$editSportPlayerFutureAtom.reportRead();
    return super.editSportPlayerFuture;
  }

  @override
  set editSportPlayerFuture(ObservableFuture<PlayerModel> value) {
    _$editSportPlayerFutureAtom.reportWrite(value, super.editSportPlayerFuture,
        () {
      super.editSportPlayerFuture = value;
    });
  }

  final _$categoryFutureAtom =
      Atom(name: '_ProfileViewmodelBase.categoryFuture');

  @override
  ObservableFuture<List<CategoryModel>> get categoryFuture {
    _$categoryFutureAtom.reportRead();
    return super.categoryFuture;
  }

  @override
  set categoryFuture(ObservableFuture<List<CategoryModel>> value) {
    _$categoryFutureAtom.reportWrite(value, super.categoryFuture, () {
      super.categoryFuture = value;
    });
  }

  final _$sportFutureAtom = Atom(name: '_ProfileViewmodelBase.sportFuture');

  @override
  ObservableFuture<List<SportModel>> get sportFuture {
    _$sportFutureAtom.reportRead();
    return super.sportFuture;
  }

  @override
  set sportFuture(ObservableFuture<List<SportModel>> value) {
    _$sportFutureAtom.reportWrite(value, super.sportFuture, () {
      super.sportFuture = value;
    });
  }

  final _$positionFutureAtom =
      Atom(name: '_ProfileViewmodelBase.positionFuture');

  @override
  ObservableFuture<List<SportPositionModel>> get positionFuture {
    _$positionFutureAtom.reportRead();
    return super.positionFuture;
  }

  @override
  set positionFuture(ObservableFuture<List<SportPositionModel>> value) {
    _$positionFutureAtom.reportWrite(value, super.positionFuture, () {
      super.positionFuture = value;
    });
  }

  final _$countryFutureAtom = Atom(name: '_ProfileViewmodelBase.countryFuture');

  @override
  ObservableFuture<List<CountryModel>> get countryFuture {
    _$countryFutureAtom.reportRead();
    return super.countryFuture;
  }

  @override
  set countryFuture(ObservableFuture<List<CountryModel>> value) {
    _$countryFutureAtom.reportWrite(value, super.countryFuture, () {
      super.countryFuture = value;
    });
  }

  final _$emirateFutureAtom = Atom(name: '_ProfileViewmodelBase.emirateFuture');

  @override
  ObservableFuture<List<EmirateModel>> get emirateFuture {
    _$emirateFutureAtom.reportRead();
    return super.emirateFuture;
  }

  @override
  set emirateFuture(ObservableFuture<List<EmirateModel>> value) {
    _$emirateFutureAtom.reportWrite(value, super.emirateFuture, () {
      super.emirateFuture = value;
    });
  }

  final _$viewsFutureAtom = Atom(name: '_ProfileViewmodelBase.viewsFuture');

  @override
  ObservableFuture<List<ViewModel>> get viewsFuture {
    _$viewsFutureAtom.reportRead();
    return super.viewsFuture;
  }

  @override
  set viewsFuture(ObservableFuture<List<ViewModel>> value) {
    _$viewsFutureAtom.reportWrite(value, super.viewsFuture, () {
      super.viewsFuture = value;
    });
  }

  final _$uploadImageFutureAtom =
      Atom(name: '_ProfileViewmodelBase.uploadImageFuture');

  @override
  ObservableFuture<bool> get uploadImageFuture {
    _$uploadImageFutureAtom.reportRead();
    return super.uploadImageFuture;
  }

  @override
  set uploadImageFuture(ObservableFuture<bool> value) {
    _$uploadImageFutureAtom.reportWrite(value, super.uploadImageFuture, () {
      super.uploadImageFuture = value;
    });
  }

  final _$deleteVideoFutureAtom =
      Atom(name: '_ProfileViewmodelBase.deleteVideoFuture');

  @override
  ObservableFuture<bool> get deleteVideoFuture {
    _$deleteVideoFutureAtom.reportRead();
    return super.deleteVideoFuture;
  }

  @override
  set deleteVideoFuture(ObservableFuture<bool> value) {
    _$deleteVideoFutureAtom.reportWrite(value, super.deleteVideoFuture, () {
      super.deleteVideoFuture = value;
    });
  }

  final _$replaceVideoFutureAtom =
      Atom(name: '_ProfileViewmodelBase.replaceVideoFuture');

  @override
  ObservableFuture<bool> get replaceVideoFuture {
    _$replaceVideoFutureAtom.reportRead();
    return super.replaceVideoFuture;
  }

  @override
  set replaceVideoFuture(ObservableFuture<bool> value) {
    _$replaceVideoFutureAtom.reportWrite(value, super.replaceVideoFuture, () {
      super.replaceVideoFuture = value;
    });
  }

  final _$_ProfileViewmodelBaseActionController =
      ActionController(name: '_ProfileViewmodelBase');

  @override
  void getSports() {
    final _$actionInfo = _$_ProfileViewmodelBaseActionController.startAction(
        name: '_ProfileViewmodelBase.getSports');
    try {
      return super.getSports();
    } finally {
      _$_ProfileViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getPostions() {
    final _$actionInfo = _$_ProfileViewmodelBaseActionController.startAction(
        name: '_ProfileViewmodelBase.getPostions');
    try {
      return super.getPostions();
    } finally {
      _$_ProfileViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getCountries() {
    final _$actionInfo = _$_ProfileViewmodelBaseActionController.startAction(
        name: '_ProfileViewmodelBase.getCountries');
    try {
      return super.getCountries();
    } finally {
      _$_ProfileViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getCategories() {
    final _$actionInfo = _$_ProfileViewmodelBaseActionController.startAction(
        name: '_ProfileViewmodelBase.getCategories');
    try {
      return super.getCategories();
    } finally {
      _$_ProfileViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getEmirates() {
    final _$actionInfo = _$_ProfileViewmodelBaseActionController.startAction(
        name: '_ProfileViewmodelBase.getEmirates');
    try {
      return super.getEmirates();
    } finally {
      _$_ProfileViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void playerViews() {
    final _$actionInfo = _$_ProfileViewmodelBaseActionController.startAction(
        name: '_ProfileViewmodelBase.playerViews');
    try {
      return super.playerViews();
    } finally {
      _$_ProfileViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fetchPlayer({int id}) {
    final _$actionInfo = _$_ProfileViewmodelBaseActionController.startAction(
        name: '_ProfileViewmodelBase.fetchPlayer');
    try {
      return super.fetchPlayer(id: id);
    } finally {
      _$_ProfileViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editPersonalInfo(
      {String dateOfBirth,
      String gender,
      String name,
      String phone,
      CountryModel country,
      CategoryModel categoryModel,
      int id}) {
    final _$actionInfo = _$_ProfileViewmodelBaseActionController.startAction(
        name: '_ProfileViewmodelBase.editPersonalInfo');
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
      _$_ProfileViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editAddressInfo(
      {String address, String area, EmirateModel emirateModel}) {
    final _$actionInfo = _$_ProfileViewmodelBaseActionController.startAction(
        name: '_ProfileViewmodelBase.editAddressInfo');
    try {
      return super.editAddressInfo(
          address: address, area: area, emirateModel: emirateModel);
    } finally {
      _$_ProfileViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editSportInfo(
      {int weight,
      int height,
      String hand,
      String leg,
      String brief,
      SportModel sport,
      SportPositionModel position}) {
    final _$actionInfo = _$_ProfileViewmodelBaseActionController.startAction(
        name: '_ProfileViewmodelBase.editSportInfo');
    try {
      return super.editSportInfo(
          weight: weight,
          height: height,
          hand: hand,
          leg: leg,
          brief: brief,
          sport: sport,
          position: position);
    } finally {
      _$_ProfileViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<int> uploadImage(
      {File file, int fileSize, String fileName, String fileType}) {
    final _$actionInfo = _$_ProfileViewmodelBaseActionController.startAction(
        name: '_ProfileViewmodelBase.uploadImage');
    try {
      return super.uploadImage(
          file: file,
          fileSize: fileSize,
          fileName: fileName,
          fileType: fileType);
    } finally {
      _$_ProfileViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<int> uploadVideo(
      {File file,
      int fileSize,
      String fileName,
      String fileType,
      int videoVersion,
      int videoId,
      bool withDelete}) {
    final _$actionInfo = _$_ProfileViewmodelBaseActionController.startAction(
        name: '_ProfileViewmodelBase.uploadVideo');
    try {
      return super.uploadVideo(
          file: file,
          fileSize: fileSize,
          fileName: fileName,
          fileType: fileType,
          videoVersion: videoVersion,
          videoId: videoId,
          withDelete: withDelete);
    } finally {
      _$_ProfileViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteVideo({int videoVersion, int videoId}) {
    final _$actionInfo = _$_ProfileViewmodelBaseActionController.startAction(
        name: '_ProfileViewmodelBase.deleteVideo');
    try {
      return super.deleteVideo(videoVersion: videoVersion, videoId: videoId);
    } finally {
      _$_ProfileViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
image: ${image},
imageId: ${imageId},
playerFuture: ${playerFuture},
editAddressPlayerFuture: ${editAddressPlayerFuture},
editPersonalPlayerFuture: ${editPersonalPlayerFuture},
editSportPlayerFuture: ${editSportPlayerFuture},
categoryFuture: ${categoryFuture},
sportFuture: ${sportFuture},
positionFuture: ${positionFuture},
countryFuture: ${countryFuture},
emirateFuture: ${emirateFuture},
viewsFuture: ${viewsFuture},
uploadImageFuture: ${uploadImageFuture},
deleteVideoFuture: ${deleteVideoFuture},
replaceVideoFuture: ${replaceVideoFuture},
player: ${player},
playerLoading: ${playerLoading},
categories: ${categories},
sports: ${sports},
countries: ${countries},
positions: ${positions},
emirates: ${emirates},
views: ${views},
deleteVideoLoading: ${deleteVideoLoading},
deleteVideoError: ${deleteVideoError},
replaceVideoLoading: ${replaceVideoLoading},
replaceVideoError: ${replaceVideoError},
imageFile: ${imageFile}
    ''';
  }
}
