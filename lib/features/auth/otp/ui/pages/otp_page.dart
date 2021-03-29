import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key key}) : super(key: key);

  static MaterialPageRoute get pageRoute => MaterialPageRoute(builder: (context) => const OtpPage());

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends ProviderMobxState<OtpPage, AuthViewmodel> {
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
    return Container();
  }
}
