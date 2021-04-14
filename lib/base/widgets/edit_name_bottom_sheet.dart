import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

void editNameBottomSheet(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: context.mediaQuery.viewInsets,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.08, vertical: context.fullHeight * 0.03),
            child: Wrap(
              children: [
                Text(
                  'Edit name',
                  style: context.textTheme.headline2.copyWith(fontSize: 20),
                ),
                MawahebTextField(
                  context: context,
                  hintColor: Colors.grey,
                  // showPassword: false,
                  hintText: 'lbl_full_name',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.04),
                  child: MawahebGradientButton(
                    onPressed: () {},
                    text: 'Edit',
                    context: context,
                  ),
                ),
                MawahebButton(
                  context: context,
                  onPressed: () {},
                  text: 'lbl_skip',
                  buttonColor: Colors.white,
                  borderColor: Colors.black,
                  textColor: Colors.black,
                )
              ],
            ),
          ),
        );
      });
}
