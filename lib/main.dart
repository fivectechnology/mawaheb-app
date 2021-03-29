import 'package:core_sdk/utils/injectable/environments.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/di/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO(abd): setup notifications
  // await setupNotifications();

  await inject(environment: prod.name);

  runApp(const App());
}

// TODO(abd): setup notifications
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'mawaheb_high_importance_channel', // id
//   'High Importance Notifications', // title
//   'This channel is used for important notifications.', // description
//   importance: Importance.max,
//   enableVibration: true,
//   enableLights: true,
//   playSound: true,
//   showBadge: true,
// );

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// Future<void> setupNotifications() async {
//   await Firebase.initializeApp();

//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);

//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

//   await FirebaseMessaging.instance.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
// }
