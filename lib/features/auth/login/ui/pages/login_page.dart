import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/features/auth/forgot_password/ui/pages/forgot_password_page.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key key,
  }) : super(key: key);

  static MaterialPageRoute get pageRoute => MaterialPageRoute(builder: (context) => const LoginPage());

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ProviderMobxState<LoginPage, AuthViewmodel> {
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
        decoration: BoxDecoration(color: theme.primaryColor),
        child: Column(
          children: [
            Text('${viewmodel.hashCode}', style: textTheme.bodyText1.copyWith(color: theme.accentColor)),
            RaisedButton(
              onPressed: () {
                context.pushPage(
                  Provider.value(
                    value: viewmodel,
                    child: const ForgotPasswordPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
