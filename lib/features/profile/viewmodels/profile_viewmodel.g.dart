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
  void fetchPlayer() {
    final _$actionInfo = _$_ProfileViewmodelBaseActionController.startAction(
        name: '_ProfileViewmodelBase.fetchPlayer');
    try {
      return super.fetchPlayer();
    } finally {
      _$_ProfileViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
playerFuture: ${playerFuture},
categoryFuture: ${categoryFuture},
sportFuture: ${sportFuture},
positionFuture: ${positionFuture},
countryFuture: ${countryFuture},
emirateFuture: ${emirateFuture},
player: ${player},
playerLoading: ${playerLoading},
categories: ${categories},
sports: ${sports},
countries: ${countries},
positions: ${positions}
    ''';
  }
}
