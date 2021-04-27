import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/app/viewmodels/app_viewmodel.dart';
import 'package:mawaheb_app/base/utils/app_bar_params.dart';
import 'package:mawaheb_app/base/utils/validators.dart';

import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';

import 'package:mawaheb_app/features/settings/viewmodels/settings_viewmodel.dart';
import 'package:provider/provider.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({
    Key key,
  }) : super(key: key);

  static const String route = '/change_email';
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static MaterialPageRoute pageRoute(SettingsViewmodel settingsViewmodel) => MaterialPageRoute(
        builder: (context) => Provider.value(
          value: settingsViewmodel,
          child: const ChangeEmailPage(),
        ),
      );

  static CupertinoPageRoute cupertionPageRoute(SettingsViewmodel settingsViewmodel) => CupertinoPageRoute(
        builder: (context) => Provider.value(
          value: settingsViewmodel,
          child: const ChangeEmailPage(),
        ),
      );

  @override
  _ChangeEmailPageState createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends ProviderMobxState<ChangeEmailPage, SettingsViewmodel> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppViewmodel>(context, listen: false).pushRoute(AppBarParams(
        title: 'lbl_change_email',
        showBackButton: true,
        onBackPressed: () => context.pop(),
      ));
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ChangeEmailPage.scaffoldKey,
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
                  validator: (value) {
                    return emailValidator(context: context, email: value);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: context.fullHeight * 0.04, bottom: context.fullHeight * 0.02),
                  child: MawahebTextField(
                    textEditingController: _passwordController,
                    context: context,
                    hintText: 'lbl_password',
                    validator: (value) {
                      return passwordValidator(context: context, password: value);
                    },
                    isSuffixIcon: true,
                    useObscure: true,
                  ),
                ),
                Observer(builder: (_) {
                  return Padding(
                    padding: EdgeInsets.only(top: context.fullHeight * 0.05, bottom: context.fullHeight * 0.04),
                    child: MawahebGradientButton(
                      text: 'lbl_change_email',
                      isLoading: viewmodel.otpLoading,
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          viewmodel.sendOTP(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
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
