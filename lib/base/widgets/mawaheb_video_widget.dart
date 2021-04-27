import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

Widget mawahebVideoWidget({String token, int videoId}) {
  return BetterPlayerListVideoPlayer(
    BetterPlayerDataSource(BetterPlayerDataSourceType.network,
        'http://54.237.125.179:8080/mawaheb/ws/rest/com.axelor.meta.db.MetaFile/$videoId/view',
        headers: {'Authorization': 'Basic $token'}),
    configuration: const BetterPlayerConfiguration(
        controlsConfiguration:
            BetterPlayerControlsConfiguration(enableFullscreen: false)),
  );
}
