import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
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

class _RegisterPageState
    extends ProviderMobxState<RegisterPage, AuthViewmodel> {
  bool showPassword = false;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
      appBar: customAppBar(context: context, title: 'Sign up', withTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 78),
              child: mawahebTextField(
                  context: context,
                  hintText: 'lbl_name',
                  textEditingController: _userNameController),
            ),
            mawahebTextField(
                context: context,
                hintText: 'lbl_email',
                textEditingController: _emailController),
            Padding(
              padding: const EdgeInsets.only(top: 78, bottom: 70),
              child: mawahebTextField(
                  context: context,
                  hintText: 'lbl_password',
                  textEditingController: _passwordController,
                  isSuffixIcon: true,
                  showPassword: showPassword,
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  }),
            ),
            Observer(builder: (_) {
              return MawahebGradientButton(
                context: context,
                text: 'lbl_sign_up',
                isLoading: viewmodel.registerLoading,
                onPressed: () => viewmodel.signUp(
                  username: _userNameController.text,
                  email: _emailController.text,
                  password: _passwordController.text,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
