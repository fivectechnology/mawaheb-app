// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_sport_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditSportViewmodel on _EditSportViewmodelBase, Store {
  Computed<List<SportModel>?>? _$sportsComputed;

  @override
  List<SportModel>? get sports =>
      (_$sportsComputed ??= Computed<List<SportModel>?>(() => super.sports,
              name: '_EditSportViewmodelBase.sports'))
          .value;
  Computed<List<SportPositionModel>?>? _$positionsComputed;

  @override
  List<SportPositionModel>? get positions => (_$positionsComputed ??=
          Computed<List<SportPositionModel>?>(() => super.positions,
              name: '_EditSportViewmodelBase.positions'))
      .value;
  Computed<bool>? _$positionsLoadingComputed;

  @override
  bool get positionsLoading => (_$positionsLoadingComputed ??= Computed<bool>(
          () => super.positionsLoading,
          name: '_EditSportViewmodelBase.positionsLoading'))
      .value;
  Computed<bool>? _$sportLoadingComputed;

  @override
  bool get sportLoading =>
      (_$sportLoadingComputed ??= Computed<bool>(() => super.sportLoading,
              name: '_EditSportViewmodelBase.sportLoading'))
          .value;
  Computed<PlayerModel?>? _$playerComputed;

  @override
  PlayerModel? get player =>
      (_$playerComputed ??= Computed<PlayerModel?>(() => super.player,
              name: '_EditSportViewmodelBase.player'))
          .value;
  Computed<bool>? _$playerLoadingComputed;

  @override
  bool get playerLoading =>
      (_$playerLoadingComputed ??= Computed<bool>(() => super.playerLoading,
              name: '_EditSportViewmodelBase.playerLoading'))
          .value;

  final _$playerFutureAtom = Atom(name: '_EditSportViewmodelBase.playerFuture');

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

  final _$sportFutureAtom = Atom(name: '_EditSportViewmodelBase.sportFuture');

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
      Atom(name: '_EditSportViewmodelBase.positionFuture');

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

  final _$editSportPlayerFutureAtom =
      Atom(name: '_EditSportViewmodelBase.editSportPlayerFuture');

  @override
  ObservableFuture<PlayerModel>? get editSportPlayerFuture {
    _$editSportPlayerFutureAtom.reportRead();
    return super.editSportPlayerFuture;
  }

  @override
  set editSportPlayerFuture(ObservableFuture<PlayerModel>? value) {
    _$editSportPlayerFutureAtom.reportWrite(value, super.editSportPlayerFuture,
        () {
      super.editSportPlayerFuture = value;
    });
  }

  final _$_EditSportViewmodelBaseActionController =
      ActionController(name: '_EditSportViewmodelBase');

  @override
  void getSports() {
    final _$actionInfo = _$_EditSportViewmodelBaseActionController.startAction(
        name: '_EditSportViewmodelBase.getSports');
    try {
      return super.getSports();
    } finally {
      _$_EditSportViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getPositions({required int? sportId}) {
    final _$actionInfo = _$_EditSportViewmodelBaseActionController.startAction(
        name: '_EditSportViewmodelBase.getPositions');
    try {
      return super.getPositions(sportId: sportId);
    } finally {
      _$_EditSportViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fetchPlayer({int? id}) {
    final _$actionInfo = _$_EditSportViewmodelBaseActionController.startAction(
        name: '_EditSportViewmodelBase.fetchPlayer');
    try {
      return super.fetchPlayer(id: id);
    } finally {
      _$_EditSportViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editSportInfo(
      {int? weight,
      int? height,
      String? hand,
      String? leg,
      String? brief,
      SportModel? sport,
      SportPositionModel? position}) {
    final _$actionInfo = _$_EditSportViewmodelBaseActionController.startAction(
        name: '_EditSportViewmodelBase.editSportInfo');
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
      _$_EditSportViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
playerFuture: ${playerFuture},
sportFuture: ${sportFuture},
positionFuture: ${positionFuture},
editSportPlayerFuture: ${editSportPlayerFuture},
sports: ${sports},
positions: ${positions},
positionsLoading: ${positionsLoading},
sportLoading: ${sportLoading},
player: ${player},
playerLoading: ${playerLoading}
    ''';
  }
}
