import 'package:flutter/material.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:mawaheb_app/features/public_info/viewmodels/public_info_viewmodels.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key key}) : super(key: key);

  static const String route = '/about_us';

  static MaterialPageRoute<dynamic> get pageRoute => MaterialPageRoute<dynamic>(builder: (_) => const AboutUsPage());

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends ProviderMobxState<AboutUsPage, PublicInfoViewmodel> {
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
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(top: context.fullHeight * 0.04),
          child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.1),
              itemCount: 3,
              itemBuilder: (context, index) {
                return aboutUsTile();
              })),
    );
  }

  Widget aboutUsTile({
    String title,
    String text,
    String image,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/ic_about_us.png'),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.01),
            child: Text(
              'Summary',
              style: textTheme.bodyText1,
            ),
          ),
          SizedBox(
            width: context.fullWidth,
            child: Text(
              'Fusce at nisi eget dolor rhoncus facilisis. Mauris ante nisl, consectetur et luctus et, porta ut dolor. Curabitur ultricies ultrices nulla. Morbi blandit nec est vitae dictum. Etiam vel consectetur diam. Maecenas vitae egestas dolor. Fusc',
              style: textTheme.bodyText2,
              // textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
