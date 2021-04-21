import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/utils/validators.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key key}) : super(key: key);

  static const String route = '/forgot_password';

  static MaterialPageRoute pageRoute(AuthViewmodel authViewmodel) =>
      MaterialPageRoute(
        builder: (context) => Provider.value(
          value: authViewmodel,
          child: const ForgotPasswordPage(),
        ),
      );

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends ProviderMobxState<ForgotPasswordPage, AuthViewmodel> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(context: context, withTitle: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.08),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      top: context.fullHeight * 0.02,
                      bottom: context.fullHeight * 0.1),
                  child: Text(
                    context.translate('msg_recover_account'),
                    style: context.textTheme.headline2
                        .copyWith(color: Colors.black, fontSize: 40),
                  )),
              MawahebTextField(
                hintText: 'lbl_email_username',
                hintColor: Colors.grey,
                validator: emailValidator,
                context: context,
                textEditingController: _emailController,
              ),
              Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: context.fullHeight * 0.1),
                  child: Observer(
                    builder: (context) {
                      return MawahebButton(
                        onPressed: () {
                          // context.navigator
                          //     .push(ResetPasswordPagee.pageRoute(viewmodel));
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            viewmodel.forgetPasswordEmail =
                                _emailController.text;
                            viewmodel.forgetPassword(
                                email: _emailController.text);
                          }
                        },
                        context: context,
                        text: 'lbl_next',
                        buttonColor: Colors.white,
                        textColor: Colors.black,
                        borderColor: Colors.black,
                      );
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
