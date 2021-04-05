import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

Widget profileDetails({BuildContext context}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: context.fullHeight * 0.02,
        horizontal: context.fullWidth * 0.04),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 52,
          backgroundColor: Color(0xFF9F9F9F),
          child: CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
        ),
        SizedBox(width: context.fullWidth * 0.02),
        Center(
          child: Text(
            'Jacob Sullivan',
            textAlign: TextAlign.center,
            style: context.textTheme.headline3
                .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        )
      ],
    ),
  );
}
