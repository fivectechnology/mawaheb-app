import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/players/viewmodels/players_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddSportPage extends StatefulWidget {
  const AddSportPage({
    Key key,
  }) : super(key: key);

  static MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (context) => const AddSportPage());

  static const String route = '/add_sport';

  @override
  _AddSportPageState createState() => _AddSportPageState();
}

class _AddSportPageState extends MobxState<AddSportPage, PlayersViewmodel> {
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
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(
          context: context,
          title: context.translate('lbl_add_sport'),
          withTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.fullWidth * 0.08,
            vertical: context.fullHeight * 0.03),
        child: ListView(
          children: [
            mawhaebDropDown(
                hint: context.translate('lbl_sport_name'), context: context),
            SizedBox(height: context.fullHeight * 0.02),
            mawhaebDropDown(
                hint: context.translate('lbl_position'), context: context),
            SizedBox(height: context.fullHeight * 0.02),
            mawahebTextField(
                hintText: context.translate('lbl_weight'),
                hintColor: Colors.grey,
                context: context),
            SizedBox(height: context.fullHeight * 0.02),
            mawahebTextField(
                hintText: context.translate('lbl_hight'),
                hintColor: Colors.grey,
                context: context),
            SizedBox(height: context.fullHeight * 0.02),
            mawhaebDropDown(
                hint: context.translate('lbl_prefer_hand'), context: context),
            SizedBox(height: context.fullHeight * 0.02),
            mawhaebDropDown(
                hint: context.translate('lbl_prefer_leg'), context: context),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: context.fullHeight * 0.03),
              child: SizedBox(
                height: context.fullHeight * 0.15,
                child: TextFormField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: const BorderSide(color: Colors.grey)),
                    hintText: context.translate('msg_brief'),
                    hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w200,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
            ),
            uploadSpace(onPress: () {
              _settingModalBottomSheet(context);
            }),
            SizedBox(height: context.fullHeight * 0.03),
            MawahebGradientButton(
              text: context.translate('lbl_next'),
              onPressed: () {},
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget uploadSpace({Function onPress}) {
    return Container(
      height: context.fullHeight * 0.14,
      decoration: DottedDecoration(
          shape: Shape.box,
          dash: const [10, 10],
          borderRadius: BorderRadius.circular(10),
          color: RED),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: onPress,
                child: SvgPicture.asset('assets/icons/ic_upload.svg')),
            Text(
              context.translate('lbl_upload_video'),
              style: textTheme.headline6,
            ),
            Text(
              context.translate('lbl_max_video'),
              style: textTheme.bodyText2.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(BuildContext context) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SizedBox(
              height: context.fullHeight * 0.9,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.fullWidth * 0.08,
                    vertical: context.fullHeight * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.translate('lbl_choose_sport'),
                      style: textTheme.headline1
                          .copyWith(fontSize: 20, letterSpacing: 0.2),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: context.fullHeight * 0.02),
                      child: SizedBox(
                        height: context.fullHeight * 0.06,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: context.translate('lbl_search_sport'),
                              hintStyle: textTheme.bodyText1
                                  .copyWith(color: Colors.grey, fontSize: 12),
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey))),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.fullHeight * 0.6,
                      child: ListView.builder(
                          itemCount: 100,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: context.fullHeight * 0.02),
                                child: Text(
                                  'Sport Name',
                                  style: textTheme.bodyText1,
                                ),
                              ),
                            );
                          }),
                    ),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: MawahebButton(
                          textColor: Colors.white,
                          buttonColor: Colors.grey[300],
                          borderColor: Colors.white,
                          text: 'lbl_add',
                          onPressed: () {},
                          context: context,
                        ),
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
