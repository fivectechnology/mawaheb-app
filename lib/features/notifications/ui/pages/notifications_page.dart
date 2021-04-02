import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/features/notifications/viewmodels/notifications_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

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

class _NotificationsPageState
    extends MobxState<NotificationsPage, NotificationsViewmodel> {
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
      backgroundColor: Colors.white,
      body: ListView.builder(
          padding: EdgeInsets.all(context.fullHeight * 0.01),
          itemCount: 10,
          itemBuilder: (context, index) {
            return notificationTile();
          }),
    );
  }

  Widget notificationTile({String title, String body, String date}) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'club Name',
            style:
                textTheme.headline1.copyWith(fontSize: 12, letterSpacing: 0.3),
          ),
          Text(
            '9:45AM',
            style:
                textTheme.bodyText1.copyWith(color: Colors.grey, fontSize: 10),
          )
        ],
      ),
      subtitle: Text(
        'Club name booked you',
        style: textTheme.headline6.copyWith(fontSize: 12),
      ),
    );
  }
}
