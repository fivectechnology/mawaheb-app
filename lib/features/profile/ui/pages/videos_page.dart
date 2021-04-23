import 'dart:io';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({Key key}) : super(key: key);

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

  Future getVideo() async {
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
          file: video);
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: isPlayer,
        child: FloatingActionButton(
          onPressed: () {
            getVideo();

            // _selectVideoBottomSheet(context);
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
              return videoRow();
            });
      }),
    );
  }

  Widget videoRow() {
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
                'Approved',
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
                    borderRadius: BorderRadius.circular(8), color: Colors.red),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      print(video);
                      print(fileType);
                      print(fileSize);
                      print(fileName);

                      // _optionVideoBottomSheet(context);
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

  void _selectVideoBottomSheet(BuildContext context) {
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
                            'you have already added 3 videos for this sportif you want to add new one remove one of uploaded videos'),
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
                          context: context, videoNumber: index + 1);
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
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _removeVideoBottomSheet(BuildContext context) {
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
                            'you are going to delete Playground Football 1 .mp4 video to confirm tab delete '),
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
                    borderColor: RED,
                  ),
                ),
                MawahebButton(
                  context: context,
                  text: 'lbl_skip',
                  buttonColor: Colors.white,
                  textColor: Colors.black,
                  borderColor: Colors.black,
                ),
              ],
            ),
          );
        });
  }

  void _optionVideoBottomSheet(BuildContext context) {
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
                  onTap: () {},
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
                  onTap: () {},
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

  Widget currentVideoRow({BuildContext context, int videoNumber}) {
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
            context.pop();
            _removeVideoBottomSheet(context);
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
