import 'package:flutter/material.dart';

Widget mawhaebDropDown({String hint}) {
  return DropdownButtonFormField(
    decoration: const InputDecoration(
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    ),
    isExpanded: true,
    icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[500]),
    hint: Text(
      hint,
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
