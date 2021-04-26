import 'package:flutter/material.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/features/public_info/data/models/about_us_model.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (viewmodel?.aboutUs == null) {
      viewmodel.getaboutUs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 26),
        child: MawahebFutureBuilder<AboutUsModel>(
            future: viewmodel.aboutUsFuture,
            onRetry: viewmodel.getaboutUs,
            onSuccess: (aboutUs) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    aboutUsTile(
                      title: 'lbl_summary',
                      image: 'assets/images/ic_summary.png',
                      text: aboutUs?.summary ?? 'null',
                    ),
                    aboutUsTile(
                      title: 'lbl_mission',
                      image: 'assets/images/ic_mission.png',
                      text: aboutUs?.mission ?? 'null',
                    ),
                    aboutUsTile(
                      title: 'lbl_vision',
                      image: 'assets/images/ic_vision.png',
                      text: aboutUs?.vision ?? 'null',
                    ),
                    aboutUsTile(
                      title: 'lbl_value',
                      image: 'assets/images/ic_value.png',
                      text: aboutUs?.coreValues ?? 'null',
                    )
                  ],
                ),
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
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image),
          const SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.01),
            child: Text(
              context.translate(title),
              style: textTheme.headline2.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyText2,
                  // textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
