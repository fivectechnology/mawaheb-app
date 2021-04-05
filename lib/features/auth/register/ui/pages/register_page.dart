import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/players/ui/pages/player_info_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key key,
  }) : super(key: key);

  static const String route = '/register';

  static MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (context) => const RegisterPage());

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
      appBar: customAppBar(context: context, title: 'login', withTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: context.fullHeight * 0.04),
              child: mawahebTextField(
                context: context,
                hintText: 'lbl_name',
              ),
            ),
            mawahebTextField(
              context: context,
              hintText: 'lbl_email',
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: context.fullHeight * 0.04,
                  bottom: context.fullHeight * 0.06),
              child: mawahebTextField(
                  context: context,
                  hintText: 'lbl_password',
                  isSuffixIcon: true,
                  showPassword: false),
            ),
            MawahebGradientButton(
              text: 'lbl_sign_up',
              onPressed: () {
                context.pushNamed(PlayerInfoPage.route);
              },
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
