import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/forgot_password/ui/pages/forgot_password_page.dart';
import 'package:mawaheb_app/features/auth/register/ui/pages/register_page.dart';
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
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPassword = false;
  String type;
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
      resizeToAvoidBottomInset: false, //new line
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.08),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 50,
                ),
                child: GradientText(
                  text: context.translate('lbl_welcome_to_mawaheb'),
                  colors: const [YELLOW, RED],
                  style: context.textTheme.headline1
                      .copyWith(fontSize: 26, letterSpacing: 0.3),
                ),
              ),
              MawahebTextField(
                context: context,
                hintText: 'lbl_email',
                textEditingController: _userNameController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 26,
                ),
                child: MawahebTextField(
                  textEditingController: _passwordController,
                  context: context,
                  hintText: 'lbl_password',
                  isSuffixIcon: true,
                  useObscure: true,
                ),
              ),
              mawhaebDropDown(
                  hint: context.translate('lbl_type'),
                  context: context,
                  items: [
                    'PLAYER',
                    'CLUB',
                  ]
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (v) {
                    type = v;
                    print(type);
                  }),
              const SizedBox(height: 26),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => context.pushNamed(ForgotPasswordPage.route,
                        arguments: viewmodel),
                    child: Text(
                      context.translate('lbl_forget_password'),
                      style: context.textTheme.subtitle1.copyWith(
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                          color: const Color(0xFF9F9F9F)),
                    ),
                  )
                ],
              ),
              Observer(builder: (_) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: context.fullHeight * 0.05,
                      bottom: context.fullHeight * 0.04),
                  child: MawahebGradientButton(
                    // TODO(ahmad): ask backend for username and password validation
                    // enable: !_userNameController.text.isNullOrEmpty && !_passwordController.text.isNullOrEmpty,
                    isLoading: viewmodel.loginLoading,
                    text: 'lbl_login',
                    onPressed: () {
                      print('aaaa');
                      print(type);
                      viewmodel.login(
                        type: type,
                        userName: _userNameController.text,
                        password: _passwordController.text,
                      );
                    },
                    context: context,
                  ),
                );
              }),
              MawahebGradientButton(
                text: 'lbl_sign_up_player',
                onPressed: () =>
                    context.pushNamed(RegisterPage.route, arguments: viewmodel),
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
