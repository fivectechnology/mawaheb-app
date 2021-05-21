import 'package:core_sdk/utils/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:mawaheb_app/app/theme/colors.dart';

class MawahebButton extends StatelessWidget {
  const MawahebButton({
    Key? key,
    this.text,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    this.onPressed,
    this.context,
    this.progressColor,
    this.isLoading = false,
    this.enable = true,
    this.textStyle,
    this.shape,
  }) : super(key: key);

  final String? text;
  final Color? textColor;
  final Color? buttonColor;
  final Function? onPressed;
  final Color? borderColor;
  final BuildContext? context;
  final bool isLoading;
  final bool enable;
  final Color? progressColor;
  final TextStyle? textStyle;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.fullHeight * 0.07,
      child: RaisedButton(
        color: buttonColor,
        onPressed: isLoading || !enable
            ? null
            : () {
                FocusScope.of(context).unfocus();
                onPressed!();
              },
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.0),
              side: BorderSide(color: borderColor!, width: 1.0),
            ),
        padding: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(80.0),
            border: Border.all(color: borderColor!, width: 1.0),
          ),
          constraints:
              const BoxConstraints(minWidth: double.infinity, minHeight: 55),
          // min sizes for Material buttons
          alignment: Alignment.center,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.translate(text!),
                style: textStyle ??
                    context.textTheme.bodyText1!.copyWith(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              ProgressBar(
                visibility: isLoading,
                padding: 8.0,
                color: progressColor ?? WHITE,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
