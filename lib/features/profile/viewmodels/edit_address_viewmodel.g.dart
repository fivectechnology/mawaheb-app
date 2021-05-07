// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_address_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditAddressViewmodel on _EditAddressViewmodelBase, Store {
  Computed<List<EmirateModel>> _$emiratesComputed;

  @override
  List<EmirateModel> get emirates =>
      (_$emiratesComputed ??= Computed<List<EmirateModel>>(() => super.emirates,
              name: '_EditAddressViewmodelBase.emirates'))
          .value;
  Computed<bool> _$emiratesLoadingComputed;

  @override
  bool get emiratesLoading =>
      (_$emiratesLoadingComputed ??= Computed<bool>(() => super.emiratesLoading,
              name: '_EditAddressViewmodelBase.emiratesLoading'))
          .value;
  Computed<PlayerModel> _$playerComputed;

  @override
  PlayerModel get player =>
      (_$playerComputed ??= Computed<PlayerModel>(() => super.player,
              name: '_EditAddressViewmodelBase.player'))
          .value;
  Computed<bool> _$playerLoadingComputed;

  @override
  bool get playerLoading =>
      (_$playerLoadingComputed ??= Computed<bool>(() => super.playerLoading,
              name: '_EditAddressViewmodelBase.playerLoading'))
          .value;

  final _$playerFutureAtom =
      Atom(name: '_EditAddressViewmodelBase.playerFuture');

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

  final _$emirateFutureAtom =
      Atom(name: '_EditAddressViewmodelBase.emirateFuture');

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

  final _$editAddressPlayerFutureAtom =
      Atom(name: '_EditAddressViewmodelBase.editAddressPlayerFuture');

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

  final _$_EditAddressViewmodelBaseActionController =
      ActionController(name: '_EditAddressViewmodelBase');

  @override
  void getEmirates() {
    final _$actionInfo = _$_EditAddressViewmodelBaseActionController
        .startAction(name: '_EditAddressViewmodelBase.getEmirates');
    try {
      return super.getEmirates();
    } finally {
      _$_EditAddressViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void fetchPlayer({int id}) {
    final _$actionInfo = _$_EditAddressViewmodelBaseActionController
        .startAction(name: '_EditAddressViewmodelBase.fetchPlayer');
    try {
      return super.fetchPlayer(id: id);
    } finally {
      _$_EditAddressViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editAddressInfo(
      {String address, String area, EmirateModel emirateModel}) {
    final _$actionInfo = _$_EditAddressViewmodelBaseActionController
        .startAction(name: '_EditAddressViewmodelBase.editAddressInfo');
    try {
      return super.editAddressInfo(
          address: address, area: area, emirateModel: emirateModel);
    } finally {
      _$_EditAddressViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
playerFuture: ${playerFuture},
emirateFuture: ${emirateFuture},
editAddressPlayerFuture: ${editAddressPlayerFuture},
emirates: ${emirates},
emiratesLoading: ${emiratesLoading},
player: ${player},
playerLoading: ${playerLoading}
    ''';
  }
}
