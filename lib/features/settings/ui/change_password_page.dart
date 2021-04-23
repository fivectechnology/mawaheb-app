import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/app/viewmodels/app_viewmodel.dart';
import 'package:mawaheb_app/base/utils/app_bar_params.dart';
import 'package:mawaheb_app/base/utils/validators.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/settings/viewmodels/settings_viewmodel.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({
    Key key,
  }) : super(key: key);

  static const String route = '/change_password';
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppViewmodel>(context, listen: false).pushRoute(AppBarParams(
        title: 'lbl_change_password',
        showBackButton: true,
        onBackPressed: () => context.pop(),
      ));
    });
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
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
      key: ChangePasswordPage.scaffoldKey,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false, //new line
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 38),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 26),
                  child: MawahebTextField(
                    context: context,
                    hintText: 'lbl_old_password',
                    textEditingController: _oldPasswordController,
                    isSuffixIcon: true,
                    validator: passwordValidator,
                    useObscure: true,
                  ),
                ),
                MawahebTextField(
                  textEditingController: _newPasswordController,
                  context: context,
                  hintText: 'lbl_new_password',
                  isSuffixIcon: true,
                  validator: passwordValidator,
                  useObscure: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 26),
                  child: MawahebTextField(
                    textEditingController: _confirmPasswordController,
                    context: context,
                    hintText: 'lbl_confirm_password',
                    validator: confirmPasswordValidator,
                    isSuffixIcon: true,
                    useObscure: true,
                  ),
                ),
                const SizedBox(height: 26),
                Observer(builder: (_) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: context.fullHeight * 0.05,
                        bottom: context.fullHeight * 0.04),
                    child: MawahebGradientButton(
                      text: 'lbl_change_password',
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          viewmodel.changePassword(
                              currentPassword: _oldPasswordController.text,
                              newPassword: _newPasswordController.text);
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
