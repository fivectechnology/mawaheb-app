import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

Widget mawahebTextField({
  String hintText,
  bool isSuffixIcon,
  Function onPressed,
  bool showPassword,
  BuildContext context,
  Color hintColor,
  TextEditingController textEditingController,
}) {
  return TextFormField(
    // ignore: avoid_bool_literals_in_conditional_expressions
    obscureText: showPassword == null ? false : !showPassword,

    controller: textEditingController,
    decoration: InputDecoration(
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey)),
      hintText: context.translate(hintText),
      hintStyle: TextStyle(
          color: hintColor ?? Colors.black,
          fontWeight: FontWeight.w200,
          fontFamily: 'Poppins'),
      suffixIcon: isSuffixIcon == true
          ? IconButton(
              onPressed: onPressed,
              icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.black),
            )
          : null,
    ),
  );
}
