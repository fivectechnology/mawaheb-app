import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key key}) : super(key: key);

  static const String route = '/forgot_password';

  static MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (context) => const ForgotPasswordPage());

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends ProviderMobxState<ForgotPasswordPage, AuthViewmodel> {
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: const [
            Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Text(
              'back',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 12),
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(
                    top: context.fullHeight * 0.02,
                    bottom: context.fullHeight * 0.1),
                child: Text(
                  'Recover \nyour account',
                  style: textTheme.headline2
                      .copyWith(color: Colors.black, fontSize: 40),
                )),
            mawahebTextField(
              hintText: 'Enter email or username',
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.1),
              child: const MawahebButton(
                text: 'Next',
                buttonColor: Colors.white,
                textColor: Colors.black,
                borderColor: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
