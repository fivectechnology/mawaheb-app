import 'package:flutter/material.dart';

Widget userListTile() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: ListTile(
      leading: Container(
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              alignment: Alignment.center,
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/images/profile.png',
              )),
        ),
      ),
      title: const Text('Club name'),
      subtitle: const Text('Club'),
    ),
  );
}