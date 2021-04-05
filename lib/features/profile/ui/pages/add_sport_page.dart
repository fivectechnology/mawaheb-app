import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/base/widgets/search_bottom_sheet.dart';
import 'package:mawaheb_app/features/players/viewmodels/players_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

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
            uploadSpace(onPress: () {}),
            SizedBox(height: context.fullHeight * 0.03),
            MawahebGradientButton(
              text: context.translate('lbl_next'),
              onPressed: () {
                searchModalBottomSheet(
                    context: context,
                    onPress: () {},
                    title: 'lbl_choose_sport');
              },
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
}
