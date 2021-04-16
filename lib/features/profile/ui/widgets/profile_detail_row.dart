import 'package:core_sdk/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

Widget profileDetails({BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 42, left: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 52,
          backgroundColor: GREY,
          child: CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
        ),
        const SizedBox(width: 16),
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
