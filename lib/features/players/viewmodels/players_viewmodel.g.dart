// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlayersViewmodel on _PlayersViewmodelBase, Store {
  Computed<ListBaseResponseModel<PlayerModel>?>? _$playersComputed;

  @override
  ListBaseResponseModel<PlayerModel>? get players => (_$playersComputed ??=
          Computed<ListBaseResponseModel<PlayerModel>?>(() => super.players,
              name: '_PlayersViewmodelBase.players'))
      .value;
  Computed<bool>? _$getPlayersComputed;

  @override
  bool get getPlayers =>
      (_$getPlayersComputed ??= Computed<bool>(() => super.getPlayers,
              name: '_PlayersViewmodelBase.getPlayers'))
          .value;
  Computed<List<SportModel>?>? _$sportsComputed;

  @override
  List<SportModel>? get sports =>
      (_$sportsComputed ??= Computed<List<SportModel>?>(() => super.sports,
              name: '_PlayersViewmodelBase.sports'))
          .value;
  Computed<List<CountryModel>?>? _$countriesComputed;

  @override
  List<CountryModel>? get countries => (_$countriesComputed ??=
          Computed<List<CountryModel>?>(() => super.countries,
              name: '_PlayersViewmodelBase.countries'))
      .value;
  Computed<List<SportPositionModel>?>? _$positionsComputed;

  @override
  List<SportPositionModel>? get positions => (_$positionsComputed ??=
          Computed<List<SportPositionModel>?>(() => super.positions,
              name: '_PlayersViewmodelBase.positions'))
      .value;
  Computed<PlayerModel?>? _$playerComputed;

  @override
  PlayerModel? get player =>
      (_$playerComputed ??= Computed<PlayerModel?>(() => super.player,
              name: '_PlayersViewmodelBase.player'))
          .value;
  Computed<bool>? _$playerLoadingComputed;

  @override
  bool get playerLoading =>
      (_$playerLoadingComputed ??= Computed<bool>(() => super.playerLoading,
              name: '_PlayersViewmodelBase.playerLoading'))
          .value;
  Computed<bool>? _$viewProfileLoadingComputed;

  @override
  bool get viewProfileLoading => (_$viewProfileLoadingComputed ??=
          Computed<bool>(() => super.viewProfileLoading,
              name: '_PlayersViewmodelBase.viewProfileLoading'))
      .value;
  Computed<List<VideoModel>?>? _$videosComputed;

  @override
  List<VideoModel>? get videos =>
      (_$videosComputed ??= Computed<List<VideoModel>?>(() => super.videos,
              name: '_PlayersViewmodelBase.videos'))
          .value;
  Computed<bool>? _$videosLoadingComputed;

  @override
  bool get videosLoading =>
      (_$videosLoadingComputed ??= Computed<bool>(() => super.videosLoading,
              name: '_PlayersViewmodelBase.videosLoading'))
          .value;
  Computed<bool>? _$viewProfileErrorComputed;

  @override
  bool get viewProfileError => (_$viewProfileErrorComputed ??= Computed<bool>(
          () => super.viewProfileError,
          name: '_PlayersViewmodelBase.viewProfileError'))
      .value;
  Computed<bool>? _$bookPlayerLoadingComputed;

  @override
  bool get bookPlayerLoading => (_$bookPlayerLoadingComputed ??= Computed<bool>(
          () => super.bookPlayerLoading,
          name: '_PlayersViewmodelBase.bookPlayerLoading'))
      .value;
  Computed<bool>? _$bookPlayerErrorComputed;

  @override
  bool get bookPlayerError =>
      (_$bookPlayerErrorComputed ??= Computed<bool>(() => super.bookPlayerError,
              name: '_PlayersViewmodelBase.bookPlayerError'))
          .value;
  Computed<bool>? _$confirmPlayerLoadingComputed;

  @override
  bool get confirmPlayerLoading => (_$confirmPlayerLoadingComputed ??=
          Computed<bool>(() => super.confirmPlayerLoading,
              name: '_PlayersViewmodelBase.confirmPlayerLoading'))
      .value;
  Computed<bool>? _$confirmPlayerErrorComputed;

  @override
  bool get confirmPlayerError => (_$confirmPlayerErrorComputed ??=
          Computed<bool>(() => super.confirmPlayerError,
              name: '_PlayersViewmodelBase.confirmPlayerError'))
      .value;
  Computed<bool>? _$releasePlayerLoadingComputed;

  @override
  bool get releasePlayerLoading => (_$releasePlayerLoadingComputed ??=
          Computed<bool>(() => super.releasePlayerLoading,
              name: '_PlayersViewmodelBase.releasePlayerLoading'))
      .value;
  Computed<bool>? _$releasePlayerErrorComputed;

  @override
  bool get releasePlayerError => (_$releasePlayerErrorComputed ??=
          Computed<bool>(() => super.releasePlayerError,
              name: '_PlayersViewmodelBase.releasePlayerError'))
      .value;
  Computed<bool>? _$statusButtonLoadingComputed;

  @override
  bool get statusButtonLoading => (_$statusButtonLoadingComputed ??=
          Computed<bool>(() => super.statusButtonLoading,
              name: '_PlayersViewmodelBase.statusButtonLoading'))
      .value;
  Computed<bool>? _$canLoadMorePlayersComputed;

  @override
  bool get canLoadMorePlayers => (_$canLoadMorePlayersComputed ??=
          Computed<bool>(() => super.canLoadMorePlayers,
              name: '_PlayersViewmodelBase.canLoadMorePlayers'))
      .value;

  final _$viewProfileFutureAtom =
      Atom(name: '_PlayersViewmodelBase.viewProfileFuture');

  @override
  ObservableFuture<bool>? get viewProfileFuture {
    _$viewProfileFutureAtom.reportRead();
    return super.viewProfileFuture;
  }

  @override
  set viewProfileFuture(ObservableFuture<bool>? value) {
    _$viewProfileFutureAtom.reportWrite(value, super.viewProfileFuture, () {
      super.viewProfileFuture = value;
    });
  }

  final _$fetchVideoFutureAtom =
      Atom(name: '_PlayersViewmodelBase.fetchVideoFuture');

  @override
  ObservableFuture<List<VideoModel>>? get fetchVideoFuture {
    _$fetchVideoFutureAtom.reportRead();
    return super.fetchVideoFuture;
  }

  @override
  set fetchVideoFuture(ObservableFuture<List<VideoModel>>? value) {
    _$fetchVideoFutureAtom.reportWrite(value, super.fetchVideoFuture, () {
      super.fetchVideoFuture = value;
    });
  }

  final _$playersFutureAtom = Atom(name: '_PlayersViewmodelBase.playersFuture');

  @override
  ObservableFuture<ListBaseResponseModel<PlayerModel>>? get playersFuture {
    _$playersFutureAtom.reportRead();
    return super.playersFuture;
  }

  @override
  set playersFuture(
      ObservableFuture<ListBaseResponseModel<PlayerModel>>? value) {
    _$playersFutureAtom.reportWrite(value, super.playersFuture, () {
      super.playersFuture = value;
    });
  }

  final _$bookPlayerFutureAtom =
      Atom(name: '_PlayersViewmodelBase.bookPlayerFuture');

  @override
  ObservableFuture<bool>? get bookPlayerFuture {
    _$bookPlayerFutureAtom.reportRead();
    return super.bookPlayerFuture;
  }

  @override
  set bookPlayerFuture(ObservableFuture<bool>? value) {
    _$bookPlayerFutureAtom.reportWrite(value, super.bookPlayerFuture, () {
      super.bookPlayerFuture = value;
    });
  }

  final _$confirmPlayerFutureAtom =
      Atom(name: '_PlayersViewmodelBase.confirmPlayerFuture');

  @override
  ObservableFuture<bool>? get confirmPlayerFuture {
    _$confirmPlayerFutureAtom.reportRead();
    return super.confirmPlayerFuture;
  }

  @override
  set confirmPlayerFuture(ObservableFuture<bool>? value) {
    _$confirmPlayerFutureAtom.reportWrite(value, super.confirmPlayerFuture, () {
      super.confirmPlayerFuture = value;
    });
  }

  final _$releasePlayerFutureAtom =
      Atom(name: '_PlayersViewmodelBase.releasePlayerFuture');

  @override
  ObservableFuture<bool>? get releasePlayerFuture {
    _$releasePlayerFutureAtom.reportRead();
    return super.releasePlayerFuture;
  }

  @override
  set releasePlayerFuture(ObservableFuture<bool>? value) {
    _$releasePlayerFutureAtom.reportWrite(value, super.releasePlayerFuture, () {
      super.releasePlayerFuture = value;
    });
  }

  final _$filterAtom = Atom(name: '_PlayersViewmodelBase.filter');

  @override
  PlayerFilterModel? get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(PlayerFilterModel? value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  final _$sportFutureAtom = Atom(name: '_PlayersViewmodelBase.sportFuture');

  @override
  ObservableFuture<List<SportModel>>? get sportFuture {
    _$sportFutureAtom.reportRead();
    return super.sportFuture;
  }

  @override
  set sportFuture(ObservableFuture<List<SportModel>>? value) {
    _$sportFutureAtom.reportWrite(value, super.sportFuture, () {
      super.sportFuture = value;
    });
  }

  final _$positionFutureAtom =
      Atom(name: '_PlayersViewmodelBase.positionFuture');

  @override
  ObservableFuture<List<SportPositionModel>>? get positionFuture {
    _$positionFutureAtom.reportRead();
    return super.positionFuture;
  }

  @override
  set positionFuture(ObservableFuture<List<SportPositionModel>>? value) {
    _$positionFutureAtom.reportWrite(value, super.positionFuture, () {
      super.positionFuture = value;
    });
  }

  final _$countryFutureAtom = Atom(name: '_PlayersViewmodelBase.countryFuture');

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

  final _$playerFutureAtom = Atom(name: '_PlayersViewmodelBase.playerFuture');

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

  final _$_PlayersViewmodelBaseActionController =
      ActionController(name: '_PlayersViewmodelBase');

  @override
  void fetchPlayer({int? id}) {
    final _$actionInfo = _$_PlayersViewmodelBaseActionController.startAction(
        name: '_PlayersViewmodelBase.fetchPlayer');
    try {
      return super.fetchPlayer(id: id);
    } finally {
      _$_PlayersViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

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
  void searchPlayers({bool fresh = false, String? query}) {
    final _$actionInfo = _$_PlayersViewmodelBaseActionController.startAction(
        name: '_PlayersViewmodelBase.searchPlayers');
    try {
      return super.searchPlayers(fresh: fresh, query: query);
    } finally {
      _$_PlayersViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void viewProfilePlayer({required int? id}) {
    final _$actionInfo = _$_PlayersViewmodelBaseActionController.startAction(
        name: '_PlayersViewmodelBase.viewProfilePlayer');
    try {
      return super.viewProfilePlayer(id: id);
    } finally {
      _$_PlayersViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void bookPlayer() {
    final _$actionInfo = _$_PlayersViewmodelBaseActionController.startAction(
        name: '_PlayersViewmodelBase.bookPlayer');
    try {
      return super.bookPlayer();
    } finally {
      _$_PlayersViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void confirmPlayer() {
    final _$actionInfo = _$_PlayersViewmodelBaseActionController.startAction(
        name: '_PlayersViewmodelBase.confirmPlayer');
    try {
      return super.confirmPlayer();
    } finally {
      _$_PlayersViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void releasePlayer() {
    final _$actionInfo = _$_PlayersViewmodelBaseActionController.startAction(
        name: '_PlayersViewmodelBase.releasePlayer');
    try {
      return super.releasePlayer();
    } finally {
      _$_PlayersViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fetchVideos({int? playerId}) {
    final _$actionInfo = _$_PlayersViewmodelBaseActionController.startAction(
        name: '_PlayersViewmodelBase.fetchVideos');
    try {
      return super.fetchVideos(playerId: playerId);
    } finally {
      _$_PlayersViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changePlayerFilter(
      {CountryModel? country,
      SportModel? sport,
      SportPositionModel? position,
      String? hand,
      String? leg,
      String? name,
      int? partnerId,
      bool? isConfirmed,
      bool? isBooked}) {
    final _$actionInfo = _$_PlayersViewmodelBaseActionController.startAction(
        name: '_PlayersViewmodelBase.changePlayerFilter');
    try {
      return super.changePlayerFilter(
          country: country,
          sport: sport,
          position: position,
          hand: hand,
          leg: leg,
          name: name,
          partnerId: partnerId,
          isConfirmed: isConfirmed,
          isBooked: isBooked);
    } finally {
      _$_PlayersViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
viewProfileFuture: ${viewProfileFuture},
fetchVideoFuture: ${fetchVideoFuture},
playersFuture: ${playersFuture},
bookPlayerFuture: ${bookPlayerFuture},
confirmPlayerFuture: ${confirmPlayerFuture},
releasePlayerFuture: ${releasePlayerFuture},
filter: ${filter},
sportFuture: ${sportFuture},
positionFuture: ${positionFuture},
countryFuture: ${countryFuture},
playerFuture: ${playerFuture},
players: ${players},
getPlayers: ${getPlayers},
sports: ${sports},
countries: ${countries},
positions: ${positions},
player: ${player},
playerLoading: ${playerLoading},
viewProfileLoading: ${viewProfileLoading},
videos: ${videos},
videosLoading: ${videosLoading},
viewProfileError: ${viewProfileError},
bookPlayerLoading: ${bookPlayerLoading},
bookPlayerError: ${bookPlayerError},
confirmPlayerLoading: ${confirmPlayerLoading},
confirmPlayerError: ${confirmPlayerError},
releasePlayerLoading: ${releasePlayerLoading},
releasePlayerError: ${releasePlayerError},
statusButtonLoading: ${statusButtonLoading},
canLoadMorePlayers: ${canLoadMorePlayers}
    ''';
  }
}
