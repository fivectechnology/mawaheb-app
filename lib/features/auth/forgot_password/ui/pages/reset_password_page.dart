import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/utils/validators.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';

class ResetPasswordPagee extends StatefulWidget {
  const ResetPasswordPagee({
    Key? key,
  }) : super(key: key);

  @override
  _ResetPasswordPageeState createState() => _ResetPasswordPageeState();
}

class _ResetPasswordPageeState extends ProviderMobxState<ResetPasswordPagee, AuthViewmodel> {
  final TextEditingController _confirmPasswordController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              padding: EdgeInsets.only(top: context.fullHeight * 0.04, bottom: context.fullHeight * 0.02),
              child: MawahebTextField(
                textEditingController: _confirmPasswordController,
                context: context,
                validator: (value) {
                  return confirmPasswordValidator(
                      password: _newPasswordController.text, context: context, confirmPassword: value);
                },
                hintText: 'lbl_confirm_password',
                isSuffixIcon: true,
                useObscure: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: context.fullHeight * 0.05, bottom: context.fullHeight * 0.04),
              child: MawahebGradientButton(
                text: 'lbl_Reset_password',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    viewmodel.resetPassword(password: _confirmPasswordController.text);
                  }
                },
                context: context,
              ),
            )
            // MawahebGradientButton(
            //   text: 'lbl_sign_up_player',
            //   onPressed: () =>
            //       context.pushNamed(RegisterPage.route, arguments: viewmodel),
            //   context: context,
            // ),
          ],
        ),
      ),
    );
  }
}
