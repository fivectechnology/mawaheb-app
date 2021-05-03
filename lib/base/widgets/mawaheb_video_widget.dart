import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';

Widget mawahebVideoWidget({String token, int videoId}) {
  return BetterPlayerListVideoPlayer(
    BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      '$BASE_REST_API/com.axelor.meta.db.MetaFile/$videoId/view',
      headers: {'Authorization': 'Basic $token'},
    ),
    configuration: const BetterPlayerConfiguration(
        controlsConfiguration: BetterPlayerControlsConfiguration(
            enableQualities: false,
            enableSubtitles: false,
            enablePlaybackSpeed: false,
            enableOverflowMenu: false,
            enableAudioTracks: false,
            enableFullscreen: false)),
  );
}
