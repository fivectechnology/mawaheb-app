import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';

class NotificationButton extends StatefulWidget {
  NotificationButton({
    this.isSelected,
    this.onChanged,
    Key key,
  }) : super(key: key);

  final Function onChanged;
  bool isSelected;

  @override
  _NotificationButtonState createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: widget.isSelected,
      onChanged: (value) {
        setState(() {
          widget.isSelected = value;
          print(widget.isSelected);
        });
      },
      activeTrackColor: RED,
      activeColor: Colors.white,
      inactiveTrackColor: Colors.grey,
    );
  }
}
