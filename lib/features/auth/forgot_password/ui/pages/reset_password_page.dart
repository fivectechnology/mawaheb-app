import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class ResetPasswordPagee extends StatefulWidget {
  const ResetPasswordPagee({
    Key key,
  }) : super(key: key);

  static const String route = '/change_password';

  static MaterialPageRoute pageRoute(AuthViewmodel authViewmodel) =>
      MaterialPageRoute(
        builder: (context) => Provider.value(
          value: authViewmodel,
          child: const ResetPasswordPagee(),
        ),
      );

  @override
  _ResetPasswordPageeState createState() => _ResetPasswordPageeState();
}

class _ResetPasswordPageeState
    extends ProviderMobxState<ResetPasswordPagee, AuthViewmodel> {
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  String confirmPasswordValidator(String password) {
    if (password.isEmpty) {
      return 'Password empty';
    } else if (password.length < 3) {
      return 'Password is too short';
    } else if (password != _newPasswordController.text) {
      return 'password not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
          withTitle: true,
          title: 'lbl_Reset_password',
          context: context,
          onBackButton: () {}),
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
                  hintText: 'lbl_new_password',
                  textEditingController: _newPasswordController,
                  isSuffixIcon: true,
                  useObscure: true,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: context.fullHeight * 0.04,
                      bottom: context.fullHeight * 0.02),
                  child: MawahebTextField(
                    textEditingController: _confirmPasswordController,
                    context: context,
                    validator: confirmPasswordValidator,
                    hintText: 'lbl_confirm_password',
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
                      text: 'lbl_Reset_password',
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          viewmodel.resetPassword(
                              password: _confirmPasswordController.text);
                          print('match');
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
