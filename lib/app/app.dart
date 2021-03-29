import 'package:core_sdk/utils/app_localizations.dart';
import 'package:core_sdk/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mawaheb_app/app/routes/router.dart';
import 'package:mawaheb_app/app/theme/mawaheb_light_theme.dart';
import 'package:mawaheb_app/app/viewmodels/app_viewmodel.dart';
import 'package:mawaheb_app/features/splash/ui/pages/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  static final GlobalKey<NavigatorState> navKey = GlobalKey(debugLabel: 'Main_Mawahib_Navigator');

  @override
  _AppState createState() => _AppState();

// TODO(abd): add local futures
  static void changeLocal(BuildContext context) {
    // _AppState state = context.ancestorStateOfType(TypeMatcher<_AppState>());

    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) => state.changeLocal(),
    // );
  }
}

class _AppState extends State<App> {
  final AppViewmodel appViewmodel = GetIt.I<AppViewmodel>();
  final SharedPreferences prefs = GetIt.I<SharedPreferences>();
  Locale locale;

  // TODO(abd): add firebase
  // final appViewModel = GetIt.I<AppViewModel>();
  // final FirebaseMessaging _firebaseMessaging = GetIt.I();

  @override
  void initState() {
    locale = Locale(prefs.getString(PreferencesKeys.APP_LANGUAGE) ?? LANGUAGE_DEFAULT);
    // TODO(abd): add firebase
    // appViewModel.configFirebase();
    super.initState();
  }

  // TODO(abd): add local futures
  // changeLocal() {
  //   setState(() {
  //     locale = Locale(prefs.getString(PreferencesKeys.APP_LANGUAGE) ?? LANGUAGE_DEFAULT);
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<AppViewmodel>(
      create: (_) => appViewmodel,
      child: MaterialApp(
        navigatorKey: App.navKey,
        locale: locale,
        initialRoute: SplashPage.route,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: PageRouter.route,
        supportedLocales: const <Locale>[
          Locale(LANGUAGE_ENGLISH),
          Locale(LANGUAGE_ARABIC),
        ],
        theme: lightTheme,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
          for (final Locale supportedLocale in supportedLocales) {
            if (locale != null && supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }
}
