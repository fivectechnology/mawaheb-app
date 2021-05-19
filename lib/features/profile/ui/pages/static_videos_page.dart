import 'package:core_sdk/utils/colors.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_video_widget.dart';
import 'package:mawaheb_app/features/profile/viewmodels/static_videos_viewmodel.dart';
import 'package:supercharged/supercharged.dart';

class StaticVideosPage extends StatefulWidget {
  const StaticVideosPage({Key? key}) : super(key: key);

  @override
  _StaticVideosPageState createState() => _StaticVideosPageState();
}

class _StaticVideosPageState extends MobxState<StaticVideosPage, StaticVideosViewmodel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      body: Observer(
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      initialValue: viewmodel.videoUrl,
                      style: context.textTheme.bodyText1,
                      onFieldSubmitted: (url) => viewmodel.changeUrl(url),
                    )),
                  ],
                ),
                SizedBox(
                  width: context.fullWidth * 0.9,
                  height: context.fullHeight * 0.5,
                  child: VideoPlayerWidget2(videoUrl: viewmodel.videoUrl),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Observer(
  //       builder: (_) {
  //         return AnimatedSwitcher(
  //           duration: 500.milliseconds,
  //           child: viewmodel.canPlay
  //               ? VideoPlayerWidget(videoUrl: viewmodel.videoUrl)
  //               : TextFormField(onFieldSubmitted: (url) => viewmodel.changeUrl(url)),
  //         );
  //       },
  //     ),
  //   );
  // }
}
