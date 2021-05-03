import 'package:core_sdk/utils/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

Future<void> mawahebShowConfirmDialog({
  BuildContext context,
  String message,
  Function onConfirm,
  TextStyle textStyle,
  TextStyle cancelButtonStyle,
  TextStyle confirmButtonStyle,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(
          message,
          style: textStyle ??
              const TextStyle(
                color: DARK_GREY,
                fontSize: 16,
              ),
        ),
        actions: [
          FlatButton(
            child: Text(
              context.translate('lbl_cancel'),
              style: cancelButtonStyle ??
                  const TextStyle(
                    color: GREY,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text(
              context.translate('lbl_confirm'),
              style: confirmButtonStyle ??
                  const TextStyle(
                    color: PRIMARY,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
            ),
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
