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

  final _$_ProfileViewmodelBaseActionController =
      ActionController(name: '_ProfileViewmodelBase');

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
player: ${player},
playerLoading: ${playerLoading}
    ''';
  }
}
