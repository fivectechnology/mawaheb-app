import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/app/viewmodels/app_viewmodel.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:mawaheb_app/features/public_info/ui/pages/public_info_page.dart';
import 'package:provider/provider.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key key}) : super(key: key);

  static MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (context) => const AuthPage());

  static const String route = '/auth';

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends MobxState<AuthPage, AuthViewmodel> {
  AppViewmodel appViewmodel;

  @override
  void initState() {
    super.initState();
    viewmodel.clearUserData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    appViewmodel = Provider.of<AppViewmodel>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TODO(ahmad): add public info tabs here with login as first tab

    return Scaffold(
      backgroundColor: WHITE,
      appBar: AppBar(
        title: Text(
          context.translate('lbl_public_info'),
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: TEXT_COLOR,
            fontWeight: FontWeight.w500,
            fontSize: 19,
            letterSpacing: 0.15,
          ),
        ),
        toolbarHeight: 56.0,
        elevation: 0,
        centerTitle: false,
      ),
      key: viewmodel.scaffoldKey,
      body: Provider(create: (_) => viewmodel, child: const PublicInfoPage()),
    );
  }
}
