import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key key,
  }) : super(key: key);

  static const String route = '/login';

  static MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (context) => const LoginPage());

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ProviderMobxState<LoginPage, AuthViewmodel> {
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
      resizeToAvoidBottomInset: false, //new line
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: context.fullHeight * 0.22,
                  bottom: context.fullHeight * 0.1),
              child: GradientText(
                text: 'Welcome to Mawaheb',
                colors: const [YELLOW, RED],
                style: textTheme.headline1
                    .copyWith(fontSize: 26, letterSpacing: 0.3),
              ),
            ),
            mawahebTextField(
              hintText: 'Email',
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: context.fullHeight * 0.04,
                  bottom: context.fullHeight * 0.02),
              child: mawahebTextField(
                  hintText: 'Password',
                  isSuffixIcon: true,
                  showPassword: false),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Text(
                    'Forget Password?',
                    style: textTheme.subtitle1.copyWith(
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        color: const Color(0xFF9F9F9F)),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: context.fullHeight * 0.05,
                  bottom: context.fullHeight * 0.04),
              child: MawahebGradientButton(text: 'Login', onPressed: () {}),
            ),
            MawahebGradientButton(text: 'Sign up as player', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
