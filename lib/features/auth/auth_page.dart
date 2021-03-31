import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/features/auth/otp/ui/pages/otp_page.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:mawaheb_app/features/public_info/ui/pages/about_us_page.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({
    Key key,
  }) : super(key: key);

  static MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (context) => const AuthPage());

  static const String route = '/auth';

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends MobxState<AuthPage, AuthViewmodel> {
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
    // TODO(ahmad): add public info tabs here with login as first tab
    return Provider(create: (_) => viewmodel, child: const AboutUsPage());
  }
}
