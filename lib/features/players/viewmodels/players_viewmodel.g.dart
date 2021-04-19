// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlayersViewmodel on _PlayersViewmodelBase, Store {
  Computed<bool> _$isConfirmedComputed;

  @override
  bool get isConfirmed =>
      (_$isConfirmedComputed ??= Computed<bool>(() => super.isConfirmed,
              name: '_PlayersViewmodelBase.isConfirmed'))
          .value;
  Computed<SportModel> _$filterCountryComputed;

  @override
  SportModel get filterCountry => (_$filterCountryComputed ??=
          Computed<SportModel>(() => super.filterCountry,
              name: '_PlayersViewmodelBase.filterCountry'))
      .value;
  Computed<SportModel> _$filterPositionComputed;

  @override
  SportModel get filterPosition => (_$filterPositionComputed ??=
          Computed<SportModel>(() => super.filterPosition,
              name: '_PlayersViewmodelBase.filterPosition'))
      .value;
  Computed<List<PlayerModel>> _$playersComputed;

  @override
  List<PlayerModel> get players =>
      (_$playersComputed ??= Computed<List<PlayerModel>>(() => super.players,
              name: '_PlayersViewmodelBase.players'))
          .value;
  Computed<List<SportModel>> _$sportsComputed;

  @override
  List<SportModel> get sports =>
      (_$sportsComputed ??= Computed<List<SportModel>>(() => super.sports,
              name: '_PlayersViewmodelBase.sports'))
          .value;
  Computed<List<CountryModel>> _$countriesComputed;

  @override
  List<CountryModel> get countries => (_$countriesComputed ??=
          Computed<List<CountryModel>>(() => super.countries,
              name: '_PlayersViewmodelBase.countries'))
      .value;
  Computed<List<SportPositionModel>> _$positionsComputed;

  @override
  List<SportPositionModel> get positions => (_$positionsComputed ??=
          Computed<List<SportPositionModel>>(() => super.positions,
              name: '_PlayersViewmodelBase.positions'))
      .value;
  Computed<PlayerModel> _$playerComputed;

  @override
  PlayerModel get player =>
      (_$playerComputed ??= Computed<PlayerModel>(() => super.player,
              name: '_PlayersViewmodelBase.player'))
          .value;
  Computed<bool> _$playerLoadingComputed;

  @override
  bool get playerLoading =>
      (_$playerLoadingComputed ??= Computed<bool>(() => super.playerLoading,
              name: '_PlayersViewmodelBase.playerLoading'))
          .value;

  final _$playerIdAtom = Atom(name: '_PlayersViewmodelBase.playerId');

  @override
  int get playerId {
    _$playerIdAtom.reportRead();
    return super.playerId;
  }

  @override
  set playerId(int value) {
    _$playerIdAtom.reportWrite(value, super.playerId, () {
      super.playerId = value;
    });
  }

  final _$playerNameAtom = Atom(name: '_PlayersViewmodelBase.playerName');

  @override
  String get playerName {
    _$playerNameAtom.reportRead();
    return super.playerName;
  }

  @override
  set playerName(String value) {
    _$playerNameAtom.reportWrite(value, super.playerName, () {
      super.playerName = value;
    });
  }

  final _$sportAtom = Atom(name: '_PlayersViewmodelBase.sport');

  @override
  SportModel get sport {
    _$sportAtom.reportRead();
    return super.sport;
  }

  @override
  set sport(SportModel value) {
    _$sportAtom.reportWrite(value, super.sport, () {
      super.sport = value;
    });
  }

  final _$countryAtom = Atom(name: '_PlayersViewmodelBase.country');

  @override
  CountryModel get country {
    _$countryAtom.reportRead();
    return super.country;
  }

  @override
  set country(CountryModel value) {
    _$countryAtom.reportWrite(value, super.country, () {
      super.country = value;
    });
  }

  final _$positionAtom = Atom(name: '_PlayersViewmodelBase.position');

  @override
  SportPositionModel get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(SportPositionModel value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

  final _$legAtom = Atom(name: '_PlayersViewmodelBase.leg');

  @override
  String get leg {
    _$legAtom.reportRead();
    return super.leg;
  }

  @override
  set leg(String value) {
    _$legAtom.reportWrite(value, super.leg, () {
      super.leg = value;
    });
  }

  final _$handAtom = Atom(name: '_PlayersViewmodelBase.hand');

  @override
  String get hand {
    _$handAtom.reportRead();
    return super.hand;
  }

  @override
  set hand(String value) {
    _$handAtom.reportWrite(value, super.hand, () {
      super.hand = value;
    });
  }

  final _$confirmedAtom = Atom(name: '_PlayersViewmodelBase.confirmed');

  @override
  bool get confirmed {
    _$confirmedAtom.reportRead();
    return super.confirmed;
  }

  @override
  set confirmed(bool value) {
    _$confirmedAtom.reportWrite(value, super.confirmed, () {
      super.confirmed = value;
    });
  }

  final _$playersFutureAtom = Atom(name: '_PlayersViewmodelBase.playersFuture');

  @override
  ObservableFuture<List<PlayerModel>> get playersFuture {
    _$playersFutureAtom.reportRead();
    return super.playersFuture;
  }

  @override
  set playersFuture(ObservableFuture<List<PlayerModel>> value) {
    _$playersFutureAtom.reportWrite(value, super.playersFuture, () {
      super.playersFuture = value;
    });
  }

  final _$sportFutureAtom = Atom(name: '_PlayersViewmodelBase.sportFuture');

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
      Atom(name: '_PlayersViewmodelBase.positionFuture');

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

  final _$countryFutureAtom = Atom(name: '_PlayersViewmodelBase.countryFuture');

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

  final _$playerFutureAtom = Atom(name: '_PlayersViewmodelBase.playerFuture');

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

  final _$_PlayersViewmodelBaseActionController =
      ActionController(name: '_PlayersViewmodelBase');

  @override
  void getSports() {
    final _$actionInfo = _$_PlayersViewmodelBaseActionController.startAction(
        name: '_PlayersViewmodelBase.getSports');
    try {
      return super.getSports();
    } finally {
      _$_PlayersViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getPositions() {
    final _$actionInfo = _$_PlayersViewmodelBaseActionController.startAction(
        name: '_PlayersViewmodelBase.getPositions');
    try {
      return super.getPositions();
    } finally {
      _$_PlayersViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getCountries() {
    final _$actionInfo = _$_PlayersViewmodelBaseActionController.startAction(
        name: '_PlayersViewmodelBase.getCountries');
    try {
      return super.getCountries();
    } finally {
      _$_PlayersViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void searchPlayers(
      {@required String country,
      @required String sport,
      @required String position,
      @required String hand,
      @required String leg}) {
    final _$actionInfo = _$_PlayersViewmodelBaseActionController.startAction(
        name: '_PlayersViewmodelBase.searchPlayers');
    try {
      return super.searchPlayers(
          country: country,
          sport: sport,
          position: position,
          hand: hand,
          leg: leg);
    } finally {
      _$_PlayersViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
playerId: ${playerId},
playerName: ${playerName},
sport: ${sport},
country: ${country},
position: ${position},
leg: ${leg},
hand: ${hand},
confirmed: ${confirmed},
playersFuture: ${playersFuture},
sportFuture: ${sportFuture},
positionFuture: ${positionFuture},
countryFuture: ${countryFuture},
playerFuture: ${playerFuture},
isConfirmed: ${isConfirmed},
filterCountry: ${filterCountry},
filterPosition: ${filterPosition},
players: ${players},
sports: ${sports},
countries: ${countries},
positions: ${positions},
player: ${player},
playerLoading: ${playerLoading}
    ''';
  }
}
