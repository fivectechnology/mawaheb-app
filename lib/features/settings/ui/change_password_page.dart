import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/settings/viewmodels/settings_viewmodel.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({
    Key key,
  }) : super(key: key);

  static const String route = '/change_password';

  static MaterialPageRoute pageRoute(SettingsViewmodel settingsViewmodel) =>
      MaterialPageRoute(
        builder: (context) => Provider.value(
          value: settingsViewmodel,
          child: const ChangePasswordPage(),
        ),
      );

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState
    extends ProviderMobxState<ChangePasswordPage, SettingsViewmodel> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
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
              MawahebTextField(
                context: context,
                hintText: 'lbl_old_password',
                textEditingController: _oldPasswordController,
                isSuffixIcon: true,
                useObscure: true,
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: context.fullHeight * 0.04,
                    bottom: context.fullHeight * 0.02),
                child: MawahebTextField(
                  textEditingController: _newPasswordController,
                  context: context,
                  hintText: 'lbl_new_password',
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
                    text: 'lbl_change_password',
                    onPressed: () {
                      viewmodel.changePassword(
                          currentPassword: _oldPasswordController.text,
                          newPassword: _newPasswordController.text);
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
    );
  }
}
