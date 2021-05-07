import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';

Widget userListTile({
  String name,
  String photoId,
  String token,
  String type,
  VoidCallback onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: ListTile(
      onTap: onTap ?? () {},
      leading: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              alignment: Alignment.center,
              fit: BoxFit.fill,
              image: photoId == null
                  ? const AssetImage(
                      'assets/images/logo_image.png',
                    )
                  : NetworkImage(
                      '$BASE_PUBLIC_API/metaFiles/$photoId/view',
                      headers: {'Authorization': 'Basic $token'},
                    )),
        ),
      ),
      title: Text(name),
      subtitle: type != null ? Text(type) : const SizedBox(),
    ),
  );
}
