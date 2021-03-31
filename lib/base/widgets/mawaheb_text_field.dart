import 'package:flutter/material.dart';

Widget mawahebTextField({
  String hintText,
  bool isSuffixIcon,
  Function onPressed,
  bool showPassword,
}) {
  return TextFormField(
    // obscureText: showPassword == null ? isSuffixIcon : !showPassword,
    decoration: InputDecoration(
      hintText: hintText,
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
