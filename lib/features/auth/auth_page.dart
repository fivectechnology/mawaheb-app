import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/app/viewmodels/app_viewmodel.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_app_bar.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:mawaheb_app/features/public_info/ui/pages/public_info_page.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key key}) : super(key: key);

  static MaterialPageRoute get pageRoute => MaterialPageRoute(builder: (context) => const AuthPage());

  static const String route = '/auth';

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends MobxState<AuthPage, AuthViewmodel> {
  AppViewmodel appViewmodel;

  @override
  void initState() {
    super.initState();
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
      appBar: MawahebAppBar(
        appViewModel: appViewmodel,
        title: 'Mawahaeb',
      ),
      key: viewmodel.scaffoldKey,
      body: Provider(create: (_) => viewmodel, child: const PublicInfoPage()),
    );
  }
}
