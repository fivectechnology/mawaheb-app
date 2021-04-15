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
  Computed<PlayerModel> _$playerComputed;

  @override
  PlayerModel get player =>
      (_$playerComputed ??= Computed<PlayerModel>(() => super.player,
              name: '_AuthViewmodelBase.player'))
          .value;
  Computed<bool> _$registerLoadingComputed;

  @override
  bool get registerLoading =>
      (_$registerLoadingComputed ??= Computed<bool>(() => super.registerLoading,
              name: '_AuthViewmodelBase.registerLoading'))
          .value;
  Computed<List<SportModel>> _$sportsComputed;

  @override
  List<SportModel> get sports =>
      (_$sportsComputed ??= Computed<List<SportModel>>(() => super.sports,
              name: '_AuthViewmodelBase.sports'))
          .value;
  Computed<List<CountryModel>> _$countriesComputed;

  @override
  List<CountryModel> get countries => (_$countriesComputed ??=
          Computed<List<CountryModel>>(() => super.countries,
              name: '_AuthViewmodelBase.countries'))
      .value;
  Computed<List<SportPositionModel>> _$positionsComputed;

  @override
  List<SportPositionModel> get positions => (_$positionsComputed ??=
          Computed<List<SportPositionModel>>(() => super.positions,
              name: '_AuthViewmodelBase.positions'))
      .value;
  Computed<List<CategoryModel>> _$categoriesComputed;

  @override
  List<CategoryModel> get categories => (_$categoriesComputed ??=
          Computed<List<CategoryModel>>(() => super.categories,
              name: '_AuthViewmodelBase.categories'))
      .value;
  Computed<List<EmirateModel>> _$emiratesComputed;

  @override
  List<EmirateModel> get emirates =>
      (_$emiratesComputed ??= Computed<List<EmirateModel>>(() => super.emirates,
              name: '_AuthViewmodelBase.emirates'))
          .value;
  Computed<bool> _$otpLoadingComputed;

  @override
  bool get otpLoading =>
      (_$otpLoadingComputed ??= Computed<bool>(() => super.otpLoading,
              name: '_AuthViewmodelBase.otpLoading'))
          .value;
  Computed<bool> _$otpErrorComputed;

  @override
  bool get otpError =>
      (_$otpErrorComputed ??= Computed<bool>(() => super.otpError,
              name: '_AuthViewmodelBase.otpError'))
          .value;
  Computed<String> _$otpCodeComputed;

  @override
  String get otpCode =>
      (_$otpCodeComputed ??= Computed<String>(() => super.otpCode,
              name: '_AuthViewmodelBase.otpCode'))
          .value;
  Computed<bool> _$verifyOTPLoadingComputed;

  @override
  bool get verifyOTPLoading => (_$verifyOTPLoadingComputed ??= Computed<bool>(
          () => super.verifyOTPLoading,
          name: '_AuthViewmodelBase.verifyOTPLoading'))
      .value;

  final _$registerSliderModelAtom =
      Atom(name: '_AuthViewmodelBase.registerSliderModel');

  @override
  PageSliderModel get registerSliderModel {
    _$registerSliderModelAtom.reportRead();
    return super.registerSliderModel;
  }

  @override
  set registerSliderModel(PageSliderModel value) {
    _$registerSliderModelAtom.reportWrite(value, super.registerSliderModel, () {
      super.registerSliderModel = value;
    });
  }

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

  final _$registerFutureAtom = Atom(name: '_AuthViewmodelBase.registerFuture');

  @override
  ObservableFuture<PlayerModel> get registerFuture {
    _$registerFutureAtom.reportRead();
    return super.registerFuture;
  }

  @override
  set registerFuture(ObservableFuture<PlayerModel> value) {
    _$registerFutureAtom.reportWrite(value, super.registerFuture, () {
      super.registerFuture = value;
    });
  }

  final _$sportFutureAtom = Atom(name: '_AuthViewmodelBase.sportFuture');

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

  final _$positionFutureAtom = Atom(name: '_AuthViewmodelBase.positionFuture');

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

  final _$categoryFutureAtom = Atom(name: '_AuthViewmodelBase.categoryFuture');

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

  final _$countryFutureAtom = Atom(name: '_AuthViewmodelBase.countryFuture');

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

  final _$emirateFutureAtom = Atom(name: '_AuthViewmodelBase.emirateFuture');

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

  final _$otpFutureAtom = Atom(name: '_AuthViewmodelBase.otpFuture');

  @override
  ObservableFuture<bool> get otpFuture {
    _$otpFutureAtom.reportRead();
    return super.otpFuture;
  }

  @override
  set otpFuture(ObservableFuture<bool> value) {
    _$otpFutureAtom.reportWrite(value, super.otpFuture, () {
      super.otpFuture = value;
    });
  }

  final _$verifyOTPFutureAtom =
      Atom(name: '_AuthViewmodelBase.verifyOTPFuture');

  @override
  ObservableFuture<String> get verifyOTPFuture {
    _$verifyOTPFutureAtom.reportRead();
    return super.verifyOTPFuture;
  }

  @override
  set verifyOTPFuture(ObservableFuture<String> value) {
    _$verifyOTPFutureAtom.reportWrite(value, super.verifyOTPFuture, () {
      super.verifyOTPFuture = value;
    });
  }

  final _$_AuthViewmodelBaseActionController =
      ActionController(name: '_AuthViewmodelBase');

  @override
  void getSports() {
    final _$actionInfo = _$_AuthViewmodelBaseActionController.startAction(
        name: '_AuthViewmodelBase.getSports');
    try {
      return super.getSports();
    } finally {
      _$_AuthViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getPostions() {
    final _$actionInfo = _$_AuthViewmodelBaseActionController.startAction(
        name: '_AuthViewmodelBase.getPostions');
    try {
      return super.getPostions();
    } finally {
      _$_AuthViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getCountries() {
    final _$actionInfo = _$_AuthViewmodelBaseActionController.startAction(
        name: '_AuthViewmodelBase.getCountries');
    try {
      return super.getCountries();
    } finally {
      _$_AuthViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getCategories() {
    final _$actionInfo = _$_AuthViewmodelBaseActionController.startAction(
        name: '_AuthViewmodelBase.getCategories');
    try {
      return super.getCategories();
    } finally {
      _$_AuthViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getEmirates() {
    final _$actionInfo = _$_AuthViewmodelBaseActionController.startAction(
        name: '_AuthViewmodelBase.getEmirates');
    try {
      return super.getEmirates();
    } finally {
      _$_AuthViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

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
  void sendOTP({String email}) {
    final _$actionInfo = _$_AuthViewmodelBaseActionController.startAction(
        name: '_AuthViewmodelBase.sendOTP');
    try {
      return super.sendOTP(email: email);
    } finally {
      _$_AuthViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void verifyOTP({String email, int code}) {
    final _$actionInfo = _$_AuthViewmodelBaseActionController.startAction(
        name: '_AuthViewmodelBase.verifyOTP');
    try {
      return super.verifyOTP(email: email, code: code);
    } finally {
      _$_AuthViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void signUp({String username, String email, String password}) {
    final _$actionInfo = _$_AuthViewmodelBaseActionController.startAction(
        name: '_AuthViewmodelBase.signUp');
    try {
      return super.signUp(username: username, email: email, password: password);
    } finally {
      _$_AuthViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeRegisterSlider(PageSliderModel pageSliderModel) {
    final _$actionInfo = _$_AuthViewmodelBaseActionController.startAction(
        name: '_AuthViewmodelBase.changeRegisterSlider');
    try {
      return super.changeRegisterSlider(pageSliderModel);
    } finally {
      _$_AuthViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addPersonalInfo(
      {String dateOfBirth,
      String gender,
      String name,
      String phone,
      CountryModel country,
      CategoryModel categoryModel}) {
    final _$actionInfo = _$_AuthViewmodelBaseActionController.startAction(
        name: '_AuthViewmodelBase.addPersonalInfo');
    try {
      return super.addPersonalInfo(
          dateOfBirth: dateOfBirth,
          gender: gender,
          name: name,
          phone: phone,
          country: country,
          categoryModel: categoryModel);
    } finally {
      _$_AuthViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAddressInfo(
      {String address, String area, EmirateModel emirateModel}) {
    final _$actionInfo = _$_AuthViewmodelBaseActionController.startAction(
        name: '_AuthViewmodelBase.addAddressInfo');
    try {
      return super.addAddressInfo(
          address: address, area: area, emirateModel: emirateModel);
    } finally {
      _$_AuthViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addSportInfo(
      {int weight,
      int height,
      String hand,
      String leg,
      String brief,
      SportModel sport,
      SportPositionModel position}) {
    final _$actionInfo = _$_AuthViewmodelBaseActionController.startAction(
        name: '_AuthViewmodelBase.addSportInfo');
    try {
      return super.addSportInfo(
          weight: weight,
          height: height,
          hand: hand,
          leg: leg,
          brief: brief,
          sport: sport,
          position: position);
    } finally {
      _$_AuthViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
registerSliderModel: ${registerSliderModel},
loginFuture: ${loginFuture},
registerFuture: ${registerFuture},
sportFuture: ${sportFuture},
positionFuture: ${positionFuture},
categoryFuture: ${categoryFuture},
countryFuture: ${countryFuture},
emirateFuture: ${emirateFuture},
otpFuture: ${otpFuture},
verifyOTPFuture: ${verifyOTPFuture},
loginLoading: ${loginLoading},
loginError: ${loginError},
player: ${player},
registerLoading: ${registerLoading},
sports: ${sports},
countries: ${countries},
positions: ${positions},
categories: ${categories},
emirates: ${emirates},
otpLoading: ${otpLoading},
otpError: ${otpError},
otpCode: ${otpCode},
verifyOTPLoading: ${verifyOTPLoading}
    ''';
  }
}
