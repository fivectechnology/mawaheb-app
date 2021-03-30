import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/features/notifications/viewmodels/notifications_viewmodel.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({
    Key key,
  }) : super(key: key);

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  static MaterialPageRoute<dynamic> get pageRoute =>
      MaterialPageRoute<dynamic>(builder: (_) => const NotificationsPage());

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends MobxState<NotificationsPage, NotificationsViewmodel> {
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
    return Container(color: theme.accentColor);
  }
}
