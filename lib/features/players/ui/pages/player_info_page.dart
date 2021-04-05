import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/players/viewmodels/players_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:mawaheb_app/features/profile/ui/pages/address_info_page.dart';

class PlayerInfoPage extends StatefulWidget {
  const PlayerInfoPage({
    Key key,
  }) : super(key: key);

  static MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (context) => const PlayerInfoPage());

  static const String route = '/player_info';

  @override
  _PlayerInfoPageState createState() => _PlayerInfoPageState();
}

class _PlayerInfoPageState extends MobxState<PlayerInfoPage, PlayersViewmodel> {
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
          context: context, title: 'lbl_personal_info', withTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.fullWidth * 0.08,
            vertical: context.fullHeight * 0.03),
        child: Column(
          children: [
            imageRow(),
            SizedBox(height: context.fullHeight * 0.02),
            mawahebTextField(
                hintText: 'lbl_full_name',
                hintColor: Colors.grey,
                context: context),
            SizedBox(height: context.fullHeight * 0.02),
            mawahebTextField(
                hintText: 'lbl_date_of_birth',
                hintColor: Colors.grey,
                context: context),
            SizedBox(height: context.fullHeight * 0.02),
            mawhaebDropDown(hint: 'lbl_nationality', context: context),
            SizedBox(height: context.fullHeight * 0.02),
            mawhaebDropDown(hint: 'lbl_category', context: context),
            SizedBox(height: context.fullHeight * 0.02),
            mawahebTextField(
                hintText: 'lbl_gender',
                hintColor: Colors.grey,
                context: context),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: MawahebGradientButton(
                    text: 'lbl_next',
                    onPressed: () {
                      context.pushPage(const AddressInfoPage());
                    },
                    context: context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget imageRow() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: context.fullWidth * 0.03),
          height: context.fullHeight * 0.12,
          width: context.fullHeight * 0.12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 2.0),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.camera_alt,
              color: Colors.grey,
            ),
          ),
        ),
        Text(
          context.translate('lbl_add_image'),
          style: textTheme.bodyText1.copyWith(color: Colors.grey, fontSize: 12),
        )
      ],
    );
  }
}
