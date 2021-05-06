import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_loader.dart';
import 'package:mawaheb_app/features/splash/viewmodels/splash_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({
    Key key,
  }) : super(key: key);

  static const String route = '/';

  static MaterialPageRoute get pageRoute => MaterialPageRoute(builder: (context) => const SplashPage());

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends MobxState<SplashPage, SplashViewmodel> {
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
      backgroundColor: WHITE,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: SvgPicture.asset(
                    'assets/images/ic_logo.svg',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            ),
            GradientText(
              text: context.translate('lbl_public_info'),
              colors: const [YELLOW, RED],
              style: context.textTheme.headline1.copyWith(fontSize: 26, letterSpacing: 0.3),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SvgPicture.asset(
                'assets/images/slogan.svg',
              ),
            ),
            const MawahebLoader(
              color: RED,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Copyright ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: TEXT_COLOR,
                    fontSize: 14,
                    fontFamily: Theme.of(context).textTheme.headline1.fontFamily,
                  ),
                ),
                const Icon(Icons.copyright, color: TEXT_COLOR),
                Text(
                  '2021 Five C Technology FZLC',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: TEXT_COLOR,
                    fontSize: 14,
                    fontFamily: Theme.of(context).textTheme.headline1.fontFamily,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
