import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

import 'mawaheb_loader.dart';

Future<void> uploadingVideoLoader(
    {required BuildContext context, GlobalKey<State>? key, String? text}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (
      BuildContext context,
    ) {
      return Dialog(
        key: key,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: MawahebLoader(),
              ),
              Text(
                context.translate(text ?? 'msg_uploading_video'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
