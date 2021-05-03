import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/base_page.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({
    Key key,
  }) : super(key: key);

  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static const String route = '/subscription';

  static MaterialPageRoute pageRoute(AuthViewmodel authViewmodel) =>
      MaterialPageRoute(
        builder: (context) => Provider.value(
          value: authViewmodel,
          child: const SubscriptionPage(),
        ),
      );

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState
    extends ProviderMobxState<SubscriptionPage, AuthViewmodel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (viewmodel.transaction == null) {
      viewmodel.playerTransaction();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          withTitle: false,
          context: context,
          leadingText: 'skip',
          onBackButton: () {
            context.pushNamedAndRemoveUntil(BasePage.route, (_) => false);
          }),
      body: Center(
        child: Observer(
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38),
              child: MawahebGradientButton(
                text: context.translate('pay'),
                onPressed: () {
                  viewmodel.confirmTransaction();
                },
                context: context,
              ),
            );
          },
        ),
      ),
    );
  }
}
