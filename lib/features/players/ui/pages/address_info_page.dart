import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/players/viewmodels/players_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

class AddressInfoPage extends StatefulWidget {
  const AddressInfoPage({
    Key key,
  }) : super(key: key);

  static MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (context) => const AddressInfoPage());

  static const String route = '/address_info';

  @override
  _AddressInfoPageState createState() => _AddressInfoPageState();
}

class _AddressInfoPageState
    extends MobxState<AddressInfoPage, PlayersViewmodel> {
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
      appBar: customAppBar(context: context, title: 'Address', withTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.fullWidth * 0.08,
            vertical: context.fullHeight * 0.03),
        child: Column(
          children: [
            mawhaebDropDown(hint: 'Emirates'),
            SizedBox(height: context.fullHeight * 0.02),
            mawahebTextField(
                hintText: 'State/province/area', hintColor: Colors.grey),
            SizedBox(height: context.fullHeight * 0.02),
            mawahebTextField(hintText: 'Address', hintColor: Colors.grey),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: MawahebGradientButton(text: 'Next', onPressed: () {}),
              ),
            )
          ],
        ),
      ),
    );
  }
}
