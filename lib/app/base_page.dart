import 'package:animations/animations.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/side_effect_mixin.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/app/viewmodels/app_viewmodel.dart';
import 'package:mawaheb_app/base/utils/app_bar_params.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_bottom_nav.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_dialog.dart';
import 'package:mawaheb_app/features/home/ui/pages/home_page.dart';
import 'package:mawaheb_app/features/notifications/ui/pages/notifications_page.dart';
import 'package:mawaheb_app/features/public_info/ui/pages/public_info_page.dart';
import 'package:mawaheb_app/features/settings/ui/settings_page.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

import '../main.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  static const String route = '/base';

  static MaterialPageRoute<dynamic> get pageRoute => MaterialPageRoute<dynamic>(builder: (_) => const BasePage());

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> with SideEffectMinxin<BasePage> {
  final List<Widget> pages = <Widget>[
    Navigator(key: HomePage.navKey, onGenerateRoute: (RouteSettings route) => HomePage.pageRoute),
    Navigator(key: NotificationsPage.navKey, onGenerateRoute: (RouteSettings route) => NotificationsPage.pageRoute),
    Navigator(key: PublicInfoPage.navKey, onGenerateRoute: (RouteSettings route) => PublicInfoPage.pageRoute),
    Navigator(key: SettingsPage.navKey, onGenerateRoute: (RouteSettings route) => SettingsPage.pageRoute),
  ];

  AppViewmodel? appViewmodel;

  @override
  void initState() {
    super.initState();
    setupNotificationHandler();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('my debug didChangeDependencies called in base page');
    appViewmodel = Provider.of<AppViewmodel>(context, listen: false);
    appViewmodel?.updateNotificationsCount();

    if (appViewmodel!.pageIndex == PageIndex.home) {
      appViewmodel!.appBarParams = AppBarParams.initial(appViewmodel!.isPlayer);
    }
    Future.delayed(500.milliseconds)
        .then((value) => appViewmodel!.changeLanguage(appViewmodel!.prefsRepository.languageCode));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: MawahebAppBar(appViewModel: appViewmodel),
        body: buildBaseScreenBody,
        bottomNavigationBar: Container(
          height: 60.0 + context.mediaQuery.padding.bottom,
          decoration: const BoxDecoration(color: WHITE, border: Border(top: BorderSide(color: LIGHT_GREY))),
          child: Column(children: <Widget>[
            Expanded(child: MawahebBottomNavigationBar(appViewModel: appViewmodel)),
          ]),
        ),
      ),
    );
  }

  Widget get buildBaseScreenBody => Observer(
        builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              Expanded(
                child: PageTransitionSwitcher(
                  duration: 400.milliseconds,
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) =>
                      FadeThroughTransition(
                    secondaryAnimation: secondaryAnimation,
                    animation: animation,
                    child: child,
                  ),
                  child: pages[appViewmodel!.pageIndex.index],
                ),
              ),
            ],
          );
        },
      );

  Future<bool> onWillPop() async {
    if (appViewmodel!.pageIndex == PageIndex.home) {
      bool exitConfirmed = false;
      await mawahebShowConfirmDialog(
          context: context, message: context.translate('msg_close_app'), onConfirm: () => exitConfirmed = true);
      // await showConfirmDialog(
      //   context,
      //   context.translate('msg_close_app'),
      //   () => exitConfirmed = true,
      // );
      return exitConfirmed;
    } else {
      appViewmodel!.navigateTo(PageIndex.home);
      return Future<bool>.value(false);
    }
  }

  // TODO(abd): setup notification handler
  void setupNotificationHandler() {
    //   FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
    //     if (message != null) {
    //       PushRouting.route(
    //         navigator: appViewModel.currentNavigator.currentState.push,
    //         message: message.data,
    //       );
    //     }
    //   });
    //
    //
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   logger.d('onResume => notification: ${message.notification} data: ${message.data}');
    // appViewmodel?.updateNotificationsCount();
    //   PushRouting.route(
    //     navigator: appViewModel.currentNavigator.currentState.push,
    //     message: message.data,
    //   );
    // });
    //
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      appViewmodel!.updateNotificationsCount();
      // logger.d('onMessage => notification: ${message.notification} data: ${message.data}');
      // final NotificationType notificationType = NotificationTypeExtension.valueOf(message.data['typeCode']);
      // if (notificationType == NotificationType.PROFILE) {
      //   getCusomerProfile();
      //   getUserProfile();
      // }
      final RemoteNotification? notification = message.notification;
      final AndroidNotification? android = message.notification?.android;
      // logger.d(
      //   'my debug 12 $android ${notification.hashCode} ${notification.title} ${notification.body}, ${channel.id} ${channel.name}',
      // );
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: PRIMARY,
                importance: Importance.max,
                priority: Priority.max,
                enableVibration: true,
                playSound: true,
                // icon: '@drawable/ic_notification',
                icon: '@drawable/ic_notification',
              ),
            ));
      }
    });
  }
}
