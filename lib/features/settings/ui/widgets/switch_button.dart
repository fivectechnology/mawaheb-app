import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';

Widget mawahebSwitchButton({required bool isSelected, Function? onChanged}) {
  return Switch(
    value: isSelected,
    onChanged: onChanged as void Function(bool)?,
    activeTrackColor: RED,
    activeColor: Colors.white,
    inactiveTrackColor: Colors.grey,
  );
}
