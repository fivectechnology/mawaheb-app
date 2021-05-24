import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

Widget mawhaebDropDown<T>({
  Key? key,
  required String hint,
  String? helperText,
  required BuildContext context,
  Color? textColor,
  List? items,
  T? value,
  Function? onChanged,
}) {
  return DropdownButtonFormField(
    style: context.textTheme.bodyText1!.copyWith(height: 0.1),
    key: key,
    value: value,
    decoration: InputDecoration(
      labelText: context.translate(hint),
      labelStyle: context.textTheme.bodyText1!.copyWith(
        height: 0.5,
        color: textColor ?? Colors.grey,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      helperText: helperText,
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey)),
    ),
    isExpanded: true,
    icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[500]),
    // hint: Text(
    //   context.translate(hint),
    //   style: TextStyle(
    //       color: textColor ?? Colors.grey,
    //       fontWeight: FontWeight.w200,
    //       fontFamily: 'Poppins'),
    //   // ignore: prefer_const_literals_to_create_immutables
    // ),
    onChanged: onChanged as void Function(T?)?,
    items: items as List<DropdownMenuItem<T>>?,
  );
}
