import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  static const String route = '/signUp';

  static MaterialPageRoute get pageRoute => MaterialPageRoute(builder: (context) => const SignUpPage());

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ProviderMobxState<SignUpPage, AuthViewmodel> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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

  String nameValidator(String name) {
    if (name.isEmpty) {
      return 'Name is empty';
    } else if (name.length < 3) {
      return 'name is too short';
    }
    return null;
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
    const Pattern pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);

    if (!regex.hasMatch(email) || email == null)
      return 'Enter a valid email address';
    else
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
                hintText: 'lbl_name',
                textEditingController: _userNameController,
                validator: nameValidator,
              ),
            ),
            MawahebTextField(
              context: context,
              hintText: 'lbl_email',
              validator: emailValidator,
              textEditingController: _emailController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45, bottom: 70),
              child: MawahebTextField(
                context: context,
                hintText: 'lbl_password',
                textEditingController: _passwordController,
                isSuffixIcon: true,
                validator: passwordValidator,
                useObscure: true,
              ),
            ),
            Observer(builder: (_) {
              return MawahebGradientButton(
                context: context,
                text: 'lbl_sign_up_player',
                isLoading: viewmodel.otpLoading,
                // onPressed: () {
                //   if (_formKey.currentState.validate()) {
                //     _formKey.currentState.save();
                //
                //     viewmodel.registerFuture = ObservableFuture.value(
                //         PlayerModel(
                //             name: _userNameController.text,
                //             email: _emailController.text,
                //             password: _passwordController.text));
                //     viewmodel.sendOTP(email: _emailController.text);
                //   }
                // },
                onPressed: () => viewmodel.sendOTP(
                  name: _userNameController.text,
                  email: _emailController.text,
                  password: _passwordController.text,
                ),
                // TODO(ahmad): use this for test
              );
            })
          ],
        ),
      ),
    );
  }
}
