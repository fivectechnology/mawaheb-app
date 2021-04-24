import 'dart:io';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_video_widget.dart';
import 'package:mawaheb_app/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({Key key}) : super(key: key);

  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static MaterialPageRoute<dynamic> get pageRoute =>
      MaterialPageRoute<dynamic>(builder: (_) => const VideosPage());

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends ProviderMobxState<VideosPage, ProfileViewmodel> {
  bool isPlayer = true;
  File video;
  String fileType;
  String fileName;
  int fileSize;

  final picker = ImagePicker();

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
  }

  Future getVideo({bool deleteVideo, int videoId, int videoVersion}) async {
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      video = File(pickedFile.path);
      fileName = video.path.split('/').last;
      fileType = fileName.split('.').last;
      fileSize = await video.length();
      viewmodel.uploadVideo(
          fileSize: fileSize,
          fileName: fileName,
          fileType: fileType,
          file: video,
          withDelete: deleteVideo,
          videoId: videoId,
          videoVersion: videoVersion);
    } else {
      print('No image selected.');
    }
    if (video != null) {
      viewmodel.showSnack(
        context.translate('msg_uploading_video'),
        duration: const Duration(seconds: 4),
        scaffoldKey: VideosPage.scaffoldKey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: VideosPage.scaffoldKey,
      floatingActionButton: Visibility(
        visible: isPlayer,
        child: FloatingActionButton(
          onPressed: () {
            if (viewmodel.player.videos.length == 2) {
              _selectVideoBottomSheet(
                context: context,
              );
            } else {
              getVideo(deleteVideo: true);
            }
          },
          backgroundColor: YELLOW,
          child: const Icon(
            Icons.add,
            color: Colors.black87,
            size: 36,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Observer(builder: (_) {
        return ListView.builder(
            itemCount: viewmodel.player.videos.length,
            itemBuilder: (context, index) {
              return videoRow(
                  videoVersion: viewmodel.player.videos[index].version,
                  videoId: viewmodel.player.videos[index].id,
                  videoShowId: viewmodel.player.videos[index].video.id,
                  token: viewmodel.prefsRepository.token,
                  status: viewmodel.player.videos[index].status);
            });
      }),
    );
  }

  Widget videoRow(
      {int videoShowId,
      String token,
      String status,
      int videoVersion,
      int videoId}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Image.asset('assets/icons/ic_approve.png'),
              ),
              const SizedBox(width: 10),
              Text(
                status,
                style: textTheme.headline2.copyWith(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                  height: context.fullHeight * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                      mawahebVideoWidget(videoId: videoShowId, token: token)),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      _optionVideoBottomSheet(
                          context: context,
                          videoId: videoId,
                          videoVersion: videoVersion);
                    },
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _selectVideoBottomSheet({
    BuildContext context,
  }) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 24),
            child: Wrap(
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/ic_otp.svg'),
                    SizedBox(width: context.fullWidth * 0.04),
                    Expanded(
                      child: Text(
                        context.translate('msg_added_3videos'),
                        style: textTheme.bodyText1.copyWith(
                            height: 1.2,
                            color: TEXT_SECONDARY_COLOR,
                            fontWeight: FontWeight.w200),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                    padding: const EdgeInsets.only(top: 52),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: viewmodel.player.videos.length,
                    itemBuilder: (context, index) {
                      return currentVideoRow(
                          context: context,
                          videoNumber: index + 1,
                          videoId: viewmodel.player.videos[index].id,
                          videoVersion: viewmodel.player.videos[index].version);
                    }),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 44,
                  ),
                  child: MawahebButton(
                    context: context,
                    text: 'lbl_skip',
                    buttonColor: Colors.white,
                    textColor: Colors.black,
                    borderColor: Colors.black,
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _removeVideoBottomSheet(
      {BuildContext context, int videoId, int videoVersion}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 24),
            child: Wrap(
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/ic_otp.svg'),
                    SizedBox(width: context.fullWidth * 0.04),
                    Expanded(
                      child: Text(
                        context.translate(
                            'you are going to delete Playground Football 1 .mp4 video to confirm tab delete'),
                        style: textTheme.bodyText1.copyWith(
                            height: 1.2,
                            color: TEXT_SECONDARY_COLOR,
                            fontWeight: FontWeight.w200),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 26),
                  child: MawahebButton(
                    context: context,
                    text: 'lbl_delete',
                    buttonColor: Colors.white,
                    textColor: RED,
                    isLoading: viewmodel.deleteVideoLoading,
                    borderColor: RED,
                    onPressed: () {
                      viewmodel.deleteVideo(
                          videoVersion: videoVersion, videoId: videoId);
                      context.pop();
                    },
                  ),
                ),
                MawahebButton(
                  context: context,
                  text: 'lbl_skip',
                  buttonColor: Colors.white,
                  textColor: Colors.black,
                  borderColor: Colors.black,
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  void _optionVideoBottomSheet(
      {BuildContext context, int videoId, int videoVersion}) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.fullWidth * 0.08,
                vertical: context.fullHeight * 0.03),
            child: Wrap(
              children: [
                InkWell(
                  onTap: () {
                    getVideo(
                        deleteVideo: false,
                        videoId: videoId,
                        videoVersion: videoVersion);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: context.fullHeight * 0.02),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        context.translate('lbl_replace'),
                        textAlign: TextAlign.center,
                        style: textTheme.bodyText1.copyWith(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey[600],
                  height: 1.0,
                ),
                InkWell(
                  onTap: () {
                    viewmodel.deleteVideo(
                        videoId: videoId, videoVersion: videoVersion);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: context.fullHeight * 0.02),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        context.translate('lbl_delete'),
                        style: textTheme.bodyText1.copyWith(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget currentVideoRow(
      {BuildContext context, int videoNumber, int videoId, int videoVersion}) {
    return Row(
      children: [
        const Icon(
          Icons.play_circle_fill,
          color: Colors.grey,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: context.fullHeight * 0.02,
              horizontal: context.fullWidth * 0.03),
          child: Text('video$videoNumber'),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            _removeVideoBottomSheet(
                context: context, videoId: videoId, videoVersion: videoVersion);
          },
          icon: const Icon(
            Icons.delete,
            color: RED,
          ),
        )
      ],
    );
  }
}
