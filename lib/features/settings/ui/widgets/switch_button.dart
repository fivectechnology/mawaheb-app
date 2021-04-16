import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';

class NotificationButton extends StatefulWidget {
  const NotificationButton({
    this.onChange,
    Key key,
  }) : super(key: key);

  final Function onChange;

  @override
  _NotificationButtonState createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  bool noti = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: noti,
      onChanged: (value) => setState(() => noti = !noti),
      activeTrackColor: RED,
      activeColor: Colors.white,
      inactiveTrackColor: Colors.grey,
    );
  }
}
