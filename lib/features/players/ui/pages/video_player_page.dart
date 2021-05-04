import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_video_widget.dart';
import 'package:mawaheb_app/features/players/viewmodels/players_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({Key key}) : super(key: key);

  static MaterialPageRoute<dynamic> get pageRoute =>
      MaterialPageRoute<dynamic>(builder: (_) => const VideoPlayerPage());

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState
    extends ProviderMobxState<VideoPlayerPage, PlayersViewmodel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (viewmodel.videos == null) {
      viewmodel.fetchVideos(playerId: viewmodel.player.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Observer(builder: (_) {
        return SingleChildScrollView(
          child: Column(
            children: [
              if (viewmodel.videos != null)
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: viewmodel.videos.length,
                    itemBuilder: (context, index) {
                      return viewmodel.videos[index].status == 'APPROVED'
                          ? videoRow(
                              videoId: viewmodel.videos[index].video.id,
                              token: viewmodel.prefsRepository.token)
                          : const SizedBox();
                    }),
              if (viewmodel.videos == null || viewmodel.videos.isEmpty)
                Center(
                  heightFactor: 10,
                  child: Text(context.translate('msg_no_videos'),
                      style: textTheme.subtitle1),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget videoRow({int videoId, String token}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: context.fullHeight * 0.3,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: mawahebVideoWidget(token: token, videoId: videoId),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
