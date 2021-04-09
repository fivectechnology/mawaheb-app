import 'package:flutter/material.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/features/public_info/data/models/about_us_model.dart';
import 'package:mawaheb_app/features/public_info/viewmodels/public_info_viewmodels.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (viewmodel?.aboutUs == null) {
      viewmodel.getaboutUs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: context.fullHeight * 0.04),
        child: MawahebFutureBuilder<AboutUsModel>(
            future: viewmodel.aboutUsFuture,
            onRetry: viewmodel.getaboutUs,
            onSuccess: (aboutUs) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/ic_about_us.png'),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.01),
                    child: Text('Summary', style: textTheme.bodyText1),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          aboutUs.summary,
                          style: textTheme.bodyText2,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  )
                ],
              );
            }),
      ),
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
