import 'dart:io';

import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:core_sdk/utils/widgets/loading_page.dart';
import 'package:core_sdk/utils/widgets/unfucus_detector.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/base/utils/validators.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_loader.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/base/widgets/uploading_video_loader.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/auth/register/ui/pages/register_page.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

class AddSportPage extends StatefulWidget {
  const AddSportPage({
    Key? key,
  }) : super(key: key);

  static MaterialPageRoute get pageRoute => MaterialPageRoute(builder: (context) => const AddSportPage());

  static const String route = '/add_sport';

  @override
  _AddSportPageState createState() => _AddSportPageState();
}

class _AddSportPageState extends ProviderMobxState<AddSportPage, AuthViewmodel> {
  final TextEditingController _hightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _briefController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SportModel? currentSport;
  SportPositionModel? position;
  String leg = 'RIGHT';
  String hand = 'RIGHT';
  File? video;
  String? fileType;
  String? fileName;
  int? fileSize;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _hightController.dispose();
    _weightController.dispose();
    _briefController.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (viewmodel?.sportFuture == null) {
      viewmodel?.getSports();
    }

    if (viewmodel?.videos == null) {
      viewmodel?.fetchVideos(playerId: viewmodel?.player!.id);
    }

    if (viewmodel?.subscriptionFuture == null) {
      viewmodel?.getSubscription();
    }
  }

  Future getVideoCamera() async {
    FocusScope.of(context).requestFocus(FocusNode());
    final pickedFile = await picker.getVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      video = File(pickedFile.path);
      fileName = video!.path.split('/').last;
      fileType = 'video/' + fileName!.split('.').last;
      fileSize = await video!.length();
      if (fileSize! <= VIDEO_SIZE) {
        viewmodel?.uploadVideo(
          fileSize: fileSize,
          fileName: fileName,
          fileType: fileType,
          file: video,
        );
        uploadingVideoLoader(context: context, key: RegisterPage.keyLoader);
      } else {
        viewmodel?.showSnack(context.translate('msg_video_size'),
            scaffoldKey: RegisterPage.scaffoldKey, duration: const Duration(seconds: 3));
      }
    } else {
      print('No image selected.');
    }
  }

  Future getVideoGallery() async {
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      video = File(pickedFile.path);
      fileName = video!.path.split('/').last;
      fileType = fileName!.split('.').last;
      fileSize = await video!.length();
      if (fileSize! <= VIDEO_SIZE) {
        viewmodel?.uploadVideo(
          fileSize: fileSize,
          fileName: fileName,
          fileType: 'video/' + fileType!,
          file: video,
        );
        uploadingVideoLoader(context: context, key: RegisterPage.keyLoader);
      } else {
        viewmodel?.showSnack(context.translate('msg_video_size'),
            scaffoldKey: RegisterPage.scaffoldKey, duration: const Duration(seconds: 3));
      }
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> test = {
      'RIGHT': context.translate('lbl_right'),
      'LEFT': context.translate('lbl_left'),
      'BOTH': context.translate('lbl_both'),
    };

    return Observer(builder: (_) {
      return LoadingPage(
        isLoading: viewmodel?.sportLoading == true ||
            viewmodel?.positionsLoading == true ||
            viewmodel?.deleteVideoLoading == true,
        loadingWidget: const Center(child: MawahebLoader()),
        barrierColor: WHITE,
        child: Form(
          key: _formKey,
          child: FocusDetector(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                mawhaebDropDown(
                  value: currentSport,
                  hint: context.translate('lbl_sport_name'),
                  context: context,
                  onChanged: (value) {
                    currentSport = value;
                    viewmodel?.getPositions(sportId: currentSport!.id);
                  },
                  items: viewmodel?.sports
                      ?.map((em) => DropdownMenuItem(
                            child: Text(em.name!),
                            value: em,
                          ))
                      .toList(),
                ),
                const SizedBox(height: 26),
                if (viewmodel?.positions != null)
                  mawhaebDropDown(
                    hint: context.translate('lbl_position'),
                    context: context,
                    onChanged: (value) {
                      position = value;
                    },
                    items: viewmodel?.positions
                        ?.map((em) => DropdownMenuItem(
                              child: Text(em.name!),
                              value: em,
                            ))
                        .toList(),
                  ),
                if (viewmodel?.positions == null)
                  InkWell(
                    onTap: () {
                      viewmodel?.showSnack(context.translate('msg_select_sport'),
                          duration: const Duration(seconds: 3), scaffoldKey: RegisterPage.scaffoldKey);
                    },
                    child: mawhaebDropDown(
                      hint: context.translate('lbl_position'),
                      context: context,
                    ),
                  ),
                const SizedBox(height: 26),
                MawahebTextField(
                  keyboardType: TextInputType.number,
                  hintText: context.translate('lbl_weight'),
                  hintColor: Colors.grey,
                  context: context,
                  validator: (value) {
                    return weightValidator(context: context, value: value ?? '');
                  },
                  textEditingController: _weightController,
                ),
                const SizedBox(height: 26),
                MawahebTextField(
                  keyboardType: TextInputType.number,
                  hintText: context.translate('lbl_hight'),
                  hintColor: Colors.grey,
                  context: context,
                  validator: (value) {
                    return heightValidator(context: context, value: value ?? '');
                  },
                  textEditingController: _hightController,
                ),
                const SizedBox(height: 26),
                mawhaebDropDown(
                    value: hand,
                    hint: context.translate('lbl_prefer_hand'),
                    context: context,
                    items: test
                        .map((key, value) {
                          return MapEntry(
                              key,
                              DropdownMenuItem(
                                value: key,
                                child: Text(value),
                              ));
                        })
                        .values
                        .toList(),
                    // ['RIGHT', 'LEFT', 'BOTH']
                    //     .map((e) => DropdownMenuItem(
                    //           child: Text(e),
                    //           value: e,
                    //         ))
                    //     .toList(),
                    onChanged: (v) {
                      hand = v;
                    }),
                const SizedBox(height: 26),
                mawhaebDropDown(
                    value: leg,
                    hint: context.translate('lbl_prefer_leg'),
                    context: context,
                    items: test
                        .map((key, value) {
                          return MapEntry(
                              key,
                              DropdownMenuItem(
                                value: key,
                                child: Text(value),
                              ));
                        })
                        .values
                        .toList(),
                    onChanged: (v) {
                      print(v);
                      print(leg);
                      leg = v;
                    }),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.03),
                  child: SizedBox(
                    height: context.fullHeight * 0.15,
                    child: TextFormField(
                      validator: (value) {
                        return briefValidator(context: context, value: value ?? '');
                      },
                      controller: _briefController,
                      maxLines: 10,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Colors.grey)),
                        hintText: context.translate('msg_brief'),
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontWeight: FontWeight.w200, fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ),
                uploadSpace(onPress: () {
                  if (viewmodel?.videos.length == 3) {
                    _deleteSomeVideosBottomSheet(context: context);
                  } else {
                    _optionPickerBottomSheet(context: context);

                    // getVideo();
                  }
                }),
                const SizedBox(height: 26),
                Observer(builder: (_) {
                  return ListView.builder(
                      padding: const EdgeInsets.only(top: 52),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: viewmodel?.videos.length,
                      itemBuilder: (context, index) {
                        return currentVideoRow(
                            context: context,
                            videoNumber: index + 1,
                            videoId: viewmodel?.videos[index].id,
                            videoVersion: viewmodel?.videos[index].version);
                      });
                }),
                const SizedBox(height: 26),
                Observer(
                  builder: (_) {
                    return MawahebGradientButton(
                      text: context.translate('lbl_next'),
                      isLoading: viewmodel?.registerLoading ?? false,
                      onPressed: () {
                        if (currentSport == null) {
                          viewmodel?.showSnack(context.translate('msg_select_sport'),
                              scaffoldKey: RegisterPage.scaffoldKey, duration: const Duration(seconds: 3));
                        } else if (position == null) {
                          viewmodel?.showSnack(context.translate('msg_select_position'),
                              scaffoldKey: RegisterPage.scaffoldKey, duration: const Duration(seconds: 3));
                        } else {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            viewmodel?.addSportInfo(
                              height: int.parse(_hightController.text),
                              weight: int.parse(_weightController.text),
                              // hand: hand ?? 'RIGHT',
                              // leg: leg ?? 'RIGHT',
                              hand: hand,
                              leg: leg,
                              brief: _briefController.text,
                              sport: currentSport ?? viewmodel?.sports!.first,
                              position: position ?? viewmodel?.positions!.first,
                            );
                          }
                        }
                      },
                      context: context,
                    );
                  },
                ),
                const SizedBox(height: 34),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget uploadSpace({Function? onPress}) {
    return InkWell(
      onTap: onPress as void Function()?,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        height: context.fullHeight * 0.14,
        decoration: DottedDecoration(
            shape: Shape.box, dash: const [10, 10], borderRadius: BorderRadius.circular(10), color: RED),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/ic_upload.svg'),
              Text(
                context.translate('lbl_upload_video'),
                style: textTheme?.headline6,
              ),
              Text(
                context.translate('lbl_max_video'),
                style: textTheme?.bodyText2!.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget currentVideoRow({required BuildContext context, int? videoNumber, int? videoId, int? videoVersion}) {
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
              viewmodel?.deleteVideo(videoVersion: videoVersion, videoId: videoId);
            },
            child: SvgPicture.asset('assets/icons/ic_delete.svg')),
      ],
    );
  }

  void _deleteSomeVideosBottomSheet({
    required BuildContext context,
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
                    // SvgPicture.asset('assets/images/confirm.svg'),
                    // SizedBox(width: context.fullWidth * 0.04),
                    Expanded(
                      child: Text(
                        context.translate('msg_delete_videos_note'),
                        style: textTheme?.headline2!.copyWith(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 32,
                    bottom: 34,
                  ),
                  child: MawahebButton(
                    context: context,
                    text: 'lbl_back',
                    buttonColor: Colors.white,
                    textColor: Colors.black,
                    borderColor: Colors.black,
                    onPressed: () {
                      context.pop(bc);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _optionPickerBottomSheet({
    required BuildContext context,
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
                    getVideoCamera();
                    bc.pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.02),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        context.translate('lbl_camera'),
                        textAlign: TextAlign.center,
                        style: textTheme?.bodyText1!.copyWith(fontSize: 20),
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
                    getVideoGallery();
                    bc.pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.02),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        context.translate('lbl_gallery'),
                        style: textTheme?.bodyText1!.copyWith(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
