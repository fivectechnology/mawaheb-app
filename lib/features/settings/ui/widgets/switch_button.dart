import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';

Widget mawahebSwitchButton({bool isSelected, Function onChanged}) {
  return Switch(
    value: isSelected,
    onChanged: onChanged,
    activeTrackColor: RED,
    activeColor: Colors.white,
    inactiveTrackColor: Colors.grey,
  );
}
