import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:mawaheb_app/base/utils/validators.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  static const String route = '/signUp';

  static MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (context) => const SignUpPage());

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ProviderMobxState<SignUpPage, AuthViewmodel> {
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String confirmPasswordValidator(String password) {
    if (password.isEmpty) {
      return 'Password empty';
    } else if (password.length < 3) {
      return 'Password is too short';
    } else if (password != _passwordController.text) {
      return 'password not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 42),
              child: MawahebTextField(
                context: context,
                hintText: 'lbl_email',
                validator: emailValidator,
                textEditingController: _emailController,
              ),
            ),
            MawahebTextField(
              context: context,
              hintText: 'lbl_password',
              textEditingController: _passwordController,
              isSuffixIcon: true,
              validator: passwordValidator,
              useObscure: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45, bottom: 70),
              child: MawahebTextField(
                context: context,
                hintText: 'lbl_confirm_password',
                textEditingController: _confirmPasswordController,
                isSuffixIcon: true,
                validator: confirmPasswordValidator,
                useObscure: true,
              ),
            ),
            Observer(builder: (_) {
              return MawahebGradientButton(
                context: context,
                text: 'lbl_sign_up_player',
                isLoading: viewmodel.otpLoading,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();

                    viewmodel.validateEmail(
                        email: _emailController.text,
                        password: _passwordController.text);
                    // viewmodel.sendOTP(
                    //   email: _emailController.text,
                    //   password: _passwordController.text,
                    // );
                  }
                },
                // onPressed: () => viewmodel.sendOTP(
                //   name: _userNameController.text,
                //   email: _emailController.text,
                //   password: _passwordController.text,
                // ),
                // TODO(ahmad): use this for test
              );
            })
          ],
        ),
      ),
    );
  }
}
