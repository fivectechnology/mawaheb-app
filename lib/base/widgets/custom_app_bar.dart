import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

Widget customAppBar(
    {String title,
    BuildContext context,
    bool withTitle,
    VoidCallback onBackButton}) {
  return AppBar(
    // automaticallyImplyLeading: true,
    titleSpacing: 0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // InkWell(
        //   onTap: () {
        //     context.pop();
        //   },
        //   child: const Icon(
        //     Icons.arrow_back_ios,
        //     color: Colors.black,
        //   ),
        // ),
        // const SizedBox(width: 10),
        GestureDetector(
          onTap: onBackButton ?? () => Navigator.of(context).pop(),
          child: Text(
            context.translate('lbl_back'),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w300, fontSize: 12),
          ),
        )
      ],
    ),
    leading: CupertinoNavigationBarBackButton(
      color: Colors.black,
      onPressed: onBackButton ?? () => Navigator.of(context).pop(),
    ),
    actions: [
      if (withTitle)
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            context.translate(title),
            style: context.textTheme.headline1.copyWith(
                fontSize: 20, color: Colors.black, letterSpacing: 0.2),
          ),
        )
    ],
  );
}
