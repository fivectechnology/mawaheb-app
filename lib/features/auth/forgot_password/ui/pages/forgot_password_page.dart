import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key key}) : super(key: key);

  static const String route = '/forgot_password';

  static MaterialPageRoute get pageRoute => MaterialPageRoute(builder: (context) => const ForgotPasswordPage());

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ProviderMobxState<ForgotPasswordPage, AuthViewmodel> {
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
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(color: theme.accentColor),
        child: Column(
          children: [
            Text('${viewmodel.hashCode}', style: textTheme.bodyText1.copyWith(color: theme.primaryColor)),
            RaisedButton(
              onPressed: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    );

    // new comment
  }
}
