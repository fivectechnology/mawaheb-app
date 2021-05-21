import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

Widget customAppBar(
    {String? title,
    required BuildContext context,
    required bool withTitle,
    bool? withBack = true,
    String? leadingText,
    VoidCallback? onBackButton}) {
  return AppBar(
      leadingWidth: context.fullWidth * 0.15,
      // automaticallyImplyLeading: true,
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (withTitle)
            Text(
              context.translate(title!),
              style: context.textTheme.headline1!.copyWith(
                  fontSize: 20, color: Colors.black, letterSpacing: 0.2),
            )
        ],
      ),
      leading: withBack == true
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: CupertinoNavigationBarBackButton(
                color: Colors.black,
                onPressed: onBackButton ?? () => Navigator.of(context).pop(),
              ),
            )
          : const SizedBox()
      // actions: [
      //   if (withTitle)
      //     Padding(
      //       padding: const EdgeInsets.all(10.0),
      //       child: Text(
      //         context.translate(title!),
      //         style: context.textTheme.headline1!.copyWith(
      //             fontSize: 20, color: Colors.black, letterSpacing: 0.2),
      //       ),
      //     )
      // ],
      );
}
