import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:mawaheb_app/app/theme/colors.dart';

Widget filterChip({BuildContext context, String text, VoidCallback onRemove}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.01),
    child: Chip(
      label: Text(
        text,
        style: context.textTheme.bodyText1.copyWith(color: Colors.white),
      ),
      backgroundColor: RED,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      onDeleted: onRemove,
      deleteIconColor: WHITE,
    ),
  );
}
