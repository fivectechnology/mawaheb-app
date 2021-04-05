import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

Widget mawhaebDropDown({String hint, BuildContext context}) {
  return DropdownButtonFormField(
    decoration: const InputDecoration(
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    ),
    isExpanded: true,
    icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[500]),
    hint: Text(
      context.translate(hint),
      style: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w200,
          fontFamily: 'Poppins'),
      // ignore: prefer_const_literals_to_create_immutables
    ),
    onChanged: (value) {},
    items: const [],
  );
}