// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_videos_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StaticVideosViewmodel on _StaticVideosViewmodelBase, Store {
  Computed<bool>? _$canPlayComputed;

  @override
  bool get canPlay => (_$canPlayComputed ??= Computed<bool>(() => super.canPlay,
          name: '_StaticVideosViewmodelBase.canPlay'))
      .value;

  final _$videoUrlAtom = Atom(name: '_StaticVideosViewmodelBase.videoUrl');

  @override
  String get videoUrl {
    _$videoUrlAtom.reportRead();
    return super.videoUrl;
  }

  @override
  set videoUrl(String value) {
    _$videoUrlAtom.reportWrite(value, super.videoUrl, () {
      super.videoUrl = value;
    });
  }

  final _$_StaticVideosViewmodelBaseActionController =
      ActionController(name: '_StaticVideosViewmodelBase');

  @override
  void changeUrl(String url) {
    final _$actionInfo = _$_StaticVideosViewmodelBaseActionController
        .startAction(name: '_StaticVideosViewmodelBase.changeUrl');
    try {
      return super.changeUrl(url);
    } finally {
      _$_StaticVideosViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
videoUrl: ${videoUrl},
canPlay: ${canPlay}
    ''';
  }
}
