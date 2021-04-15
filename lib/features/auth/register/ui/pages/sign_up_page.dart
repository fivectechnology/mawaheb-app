import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:mobx/mobx.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  static const String route = '/signUp';

  static MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (context) => const SignUpPage());

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ProviderMobxState<SignUpPage, AuthViewmodel> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 42),
            child: MawahebTextField(
              context: context,
              hintText: 'lbl_name',
              textEditingController: _userNameController,
            ),
          ),
          MawahebTextField(
              context: context,
              hintText: 'lbl_email',
              textEditingController: _emailController),
          Padding(
            padding: const EdgeInsets.only(top: 45, bottom: 70),
            child: MawahebTextField(
              context: context,
              hintText: 'lbl_password',
              textEditingController: _passwordController,
              isSuffixIcon: true,
              useObscure: true,
            ),
          ),
          Observer(builder: (_) {
            return MawahebGradientButton(
              context: context,
              text: 'lbl_sign_up',
              isLoading: viewmodel.registerLoading,
              onPressed: () {
                viewmodel.registerFuture = ObservableFuture.value(PlayerModel(
                    name: _userNameController.text,
                    email: _emailController.text,
                    password: _passwordController.text));
                viewmodel.sendOTP(email: _emailController.text);
              },
              // onPressed: () => viewmodel.signUp(
              //   username: _userNameController.text,
              //   email: _emailController.text,
              //   password: _passwordController.text,
              // ),
              // TODO(ahmad): use this for test
            );
          })
        ],
      ),
    );
  }
}
