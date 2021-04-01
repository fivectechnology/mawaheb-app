import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

Widget customAppBar({String title, BuildContext context, bool withTitle}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      children: [
        InkWell(
          onTap: () {
            context.pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'back',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w300, fontSize: 12),
        )
      ],
    ),
    actions: [
      if (withTitle)
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title,
            style: context.textTheme.headline1.copyWith(
                fontSize: 20, color: Colors.black, letterSpacing: 0.2),
          ),
        )
    ],
  );
}
