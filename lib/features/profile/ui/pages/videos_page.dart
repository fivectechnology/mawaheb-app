import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_loader.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_video_widget.dart';
import 'package:mawaheb_app/base/widgets/uploading_video_loader.dart';
import 'package:mawaheb_app/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:video_player/video_player.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({Key key}) : super(key: key);

  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static final GlobalKey<State> keyLoader = GlobalKey<State>();

  static MaterialPageRoute<dynamic> get pageRoute => MaterialPageRoute<dynamic>(builder: (_) => const VideosPage());

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
  VideoPlayerController _controller;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    // _initPlayer();
    _controller = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    _chewieController = ChewieController(
      allowedScreenSleep: false,
      allowFullScreen: true,

      // deviceOrientationsAfterFullScreen: [
      //   DeviceOrientation.landscapeRight,
      //   DeviceOrientation.landscapeLeft,
      //   DeviceOrientation.portraitUp,
      //   DeviceOrientation.portraitDown,
      // ],
      videoPlayerController: _controller,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      autoPlay: false,
      showControls: true,
    );
  }

  Future<void> _initPlayer() async {
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
      ),
    );

    _controller.addListener(() {
      setState(() {});
    });
    await _controller.setLooping(true);
    await _controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (viewmodel.videos.isEmpty) {
      viewmodel.fetchVideos(playerId: viewmodel.player.id);
    }
  }

  Future getVideoGallery({bool deleteVideo, int videoId, int videoVersion}) async {
    final pickedFile = await ImagePicker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      video = File(pickedFile.path);
      fileName = video.path.split('/').last;
      fileType = 'video/' + fileName.split('.').last;
      fileSize = await video.length();

      print(video);
      print(fileName);
      print(fileType);
      print(fileSize);
      if (fileSize <= 5000000) {
        viewmodel.uploadVideo(
          file: video,
          withDelete: deleteVideo,
          videoId: videoId,
          videoVersion: videoVersion,
        );

        uploadingVideoLoader(context: context, key: VideosPage.keyLoader);
      } else {
        viewmodel.showSnack(context.translate('msg_video_size'),
            scaffoldKey: VideosPage.scaffoldKey, duration: const Duration(seconds: 3));
      }
    } else {
      print('No image selected.');
    }
  }

  Future getVideoCamera({
    bool deleteVideo,
    int videoId,
    int videoVersion,
  }) async {
    final pickedFile = await ImagePicker.pickVideo(source: ImageSource.camera);

    if (pickedFile != null) {
      video = File(pickedFile.path);
      fileName = video.path.split('/').last;
      fileType = 'video/' + fileName.split('.').last;
      fileSize = await video.length();

      print(video);
      print(fileName);
      print(fileType);
      print(fileSize);

      if (fileSize <= 5000000) {
        viewmodel.uploadVideo(
          file: video,
          withDelete: deleteVideo,
          videoId: videoId,
          videoVersion: videoVersion,
        );

        uploadingVideoLoader(context: context, key: VideosPage.keyLoader);
      } else {
        viewmodel.showSnack(context.translate('msg_video_size'),
            scaffoldKey: VideosPage.scaffoldKey, duration: const Duration(seconds: 3));
      }
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: VideosPage.scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (viewmodel.videos.length == 3) {
            _selectVideoBottomSheet(
              context: context,
            );
          } else {
            _optionPickerBottomSheet(context: context);
            // getVideo(deleteVideo: true);
          }
        },
        backgroundColor: YELLOW,
        child: const Icon(
          Icons.add,
          color: Colors.black87,
          size: 36,
        ),
      ),
      backgroundColor: Colors.white,
      body: Observer(builder: (_) {
        return viewmodel.videosLoading != false
            ? const Center(child: MawahebLoader())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    if (viewmodel.videos != null)
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: viewmodel.videos.length,
                          itemBuilder: (context, index) {
                            return videoRow(
                                videoVersion: viewmodel.videos[index].version,
                                videoId: viewmodel.videos[index].id,
                                videoShowId: viewmodel.videos[index].video.id,
                                token: viewmodel.prefsRepository.token,
                                status: viewmodel.videos[index].status);
                          }),
                    if (viewmodel.videos.isEmpty)
                      Center(
                        heightFactor: 10,
                        child: Text(context.translate('msg_no_videos'), style: textTheme.subtitle1),
                      ),
                  ],
                ),
              );
      }),
    );
  }

  Widget videoRow({int videoShowId, String token, String status, int videoVersion, int videoId}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              if (status == 'PENDING')
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset('assets/icons/ic_pending.svg'),
                ),
              if (status == 'APPROVED')
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset('assets/icons/ic_approve.svg'),
                ),
              if (status == 'REJECTED')
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SvgPicture.asset('assets/icons/ic_rejected.svg'),
                ),
              const SizedBox(width: 10),
              Text(
                status,
                style: textTheme.headline2.copyWith(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          Stack(
            children: [
              Center(
                child: Container(
                  height: context.fullHeight * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Chewie(
                    controller: _chewieController,
                  ),
                  // _controller.value.initialized
                  //     ? AspectRatio(
                  //         aspectRatio: _controller.value.aspectRatio,
                  //         child: VideoPlayer(_controller),
                  //       )
                  //     : Container(),
                  // mawahebVideoWidget(videoId: videoShowId, token: token)
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      _optionVideoBottomSheet(context: context, videoId: videoId, videoVersion: videoVersion);
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12), color: Colors.transparent.withOpacity(0.6)),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.center,
              //   child: IconButton(
              //     onPressed: () {
              //       setState(() {
              //         _controller.value.isPlaying
              //             ? _controller.pause()
              //             : _controller.play();
              //       });
              //     },
              //     icon: Icon(_controller.value.isPlaying
              //         ? Icons.play_circle_fill
              //         : Icons.pause_circle_filled),
              //   ),
              // )
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
        useRootNavigator: true,
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 24),
            child: Wrap(
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/images/note_image.svg'),
                    SizedBox(width: context.fullWidth * 0.04),
                    Expanded(
                      child: Text(
                        context.translate('msg_added_3videos'),
                        style: textTheme.bodyText1
                            .copyWith(height: 1.2, color: TEXT_SECONDARY_COLOR, fontWeight: FontWeight.w200),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                    padding: const EdgeInsets.only(top: 52),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: viewmodel.videos.length,
                    itemBuilder: (context, index) {
                      return currentVideoRow(
                          context: context,
                          videoNumber: index + 1,
                          videoId: viewmodel.videos[index].id,
                          videoVersion: viewmodel.videos[index].version);
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
                      Navigator.pop(bc);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _removeVideoBottomSheet({BuildContext context, int videoId, int videoVersion, int videoNumber}) {
    showModalBottomSheet(
        useRootNavigator: true,
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 24),
            child: Wrap(
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/images/delete_video.svg'),
                    SizedBox(width: context.fullWidth * 0.04),
                    Expanded(
                      child: Text(
                        context.translate('msg_delete_video') +
                            videoNumber.toString() +
                            context.translate('msg_delete_video2'),
                        style: textTheme.bodyText1
                            .copyWith(height: 1.2, color: TEXT_SECONDARY_COLOR, fontWeight: FontWeight.w200),
                      ),
                    )
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
                      viewmodel.deleteVideo(videoVersion: videoVersion, videoId: videoId);
                      bc.pop();
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
                    bc.pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  void _optionVideoBottomSheet({BuildContext context, int videoId, int videoVersion}) {
    showModalBottomSheet(
        useRootNavigator: true,
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.08, vertical: context.fullHeight * 0.03),
            child: Wrap(
              children: [
                InkWell(
                  onTap: () {
                    getVideoGallery(deleteVideo: false, videoId: videoId, videoVersion: videoVersion);
                    bc.pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.02),
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
                    viewmodel.deleteVideo(videoId: videoId, videoVersion: videoVersion);
                    bc.pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.02),
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

  void _optionPickerBottomSheet({
    BuildContext context,
  }) {
    showModalBottomSheet(
        useRootNavigator: true,
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.08, vertical: context.fullHeight * 0.03),
            child: Wrap(
              children: [
                InkWell(
                  onTap: () {
                    getVideoCamera(deleteVideo: true);
                    bc.pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.02),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        context.translate('lbl_camera'),
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
                    getVideoGallery(deleteVideo: true);
                    bc.pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.02),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        context.translate('lbl_gallery'),
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

  Widget currentVideoRow({BuildContext context, int videoNumber, int videoId, int videoVersion}) {
    return Row(
      children: [
        const Icon(
          Icons.play_circle_fill,
          color: Colors.grey,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.02, horizontal: context.fullWidth * 0.03),
          child: Text('video$videoNumber'),
        ),
        const Spacer(),
        InkWell(
            onTap: () {
              context.pop();
              _removeVideoBottomSheet(
                  context: context, videoId: videoId, videoVersion: videoVersion, videoNumber: videoNumber);
            },
            child: SvgPicture.asset('assets/icons/ic_delete.svg')),
      ],
    );
  }
}
