// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// import 'package:mawaheb_app/base/utils/api_helper.dart';
// import 'package:mawaheb_app/base/widgets/mawaheb_loader.dart';
//
// Widget mawahebVideoWidget({String token, int videoId}) {
//   return AspectRatio(
//     aspectRatio: 16 / 9,
//     child: BetterPlayerListVideoPlayer(
//       BetterPlayerDataSource(
//         BetterPlayerDataSourceType.network,
//         '$BASE_REST_API/com.axelor.meta.db.MetaFile/$videoId/view',
//         headers: {'Authorization': 'Basic $token'},
//       ),
//       configuration: const BetterPlayerConfiguration(
//           allowedScreenSleep: true,
//           autoPlay: false,
//           looping: false,
//           autoDispose: false,
//           controlsConfiguration: BetterPlayerControlsConfiguration(
//               loadingWidget: MawahebLoader(),
//               enableSkips: false,
//               enableQualities: false,
//               enableSubtitles: false,
//               enablePlaybackSpeed: false,
//               enableOverflowMenu: false,
//               enableAudioTracks: false,
//               enableFullscreen: false)),
//     ),
//   );
// }
