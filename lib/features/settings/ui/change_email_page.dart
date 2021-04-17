import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/settings/ui/setting_otp_page.dart';

import 'package:mawaheb_app/features/settings/viewmodels/settings_viewmodel.dart';
import 'package:provider/provider.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({
    Key key,
  }) : super(key: key);

  static const String route = '/change_email';

  static MaterialPageRoute pageRoute(SettingsViewmodel settingsViewmodel) =>
      MaterialPageRoute(
        builder: (context) => Provider.value(
          value: settingsViewmodel,
          child: const ChangeEmailPage(),
        ),
      );

  @override
  _ChangeEmailPageState createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState
    extends ProviderMobxState<ChangeEmailPage, SettingsViewmodel> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String passwordValidator(String password) {
    if (password.isEmpty) {
      return 'Password empty';
    } else if (password.length < 3) {
      return 'Password is too short';
    }
    return null;
  }

  String emailValidator(String email) {
    const Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r'{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]'
        r'{0,253}[a-zA-Z0-9])?)*$';
    final RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(email) || email == null)
      return 'Enter a valid email address';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, //new line
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.08),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MawahebTextField(
                  context: context,
                  hintText: 'lbl_new_email',
                  textEditingController: _emailController,
                  validator: emailValidator,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: context.fullHeight * 0.04,
                      bottom: context.fullHeight * 0.02),
                  child: MawahebTextField(
                    textEditingController: _passwordController,
                    context: context,
                    hintText: 'lbl_password',
                    validator: passwordValidator,
                    isSuffixIcon: true,
                    useObscure: true,
                  ),
                ),
                Observer(builder: (_) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: context.fullHeight * 0.05,
                        bottom: context.fullHeight * 0.04),
                    child: MawahebGradientButton(
                      text: 'lbl_change_email',
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          viewmodel.sendOTP(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          context.navigator
                              .push(SettingOtpPage.pageRoute(viewmodel));
                        }
                      },
                      context: context,
                    ),
                  );
                }),
                // MawahebGradientButton(
                //   text: 'lbl_sign_up_player',
                //   onPressed: () =>
                //       context.pushNamed(RegisterPage.route, arguments: viewmodel),
                //   context: context,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
