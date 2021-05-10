import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';

Widget userListTile({
  required String name,
  String? photoId,
  String? token,
  String? type,
  VoidCallback? onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: ListTile(
      // onTap: onTap ?? () {},
      leading: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              alignment: Alignment.center,
              fit: BoxFit.fill,
              image: (photoId == null
                  ? const AssetImage(
                      'assets/images/logo_image.png',
                    )
                  : NetworkImage(
                      '$BASE_PUBLIC_API/metaFiles/$photoId/view',
                      headers: {'Authorization': 'Basic $token'},
                    )) as ImageProvider<Object>),
        ),
      ),
      title: Text(name),
      subtitle: type != null ? Text(type) : const SizedBox(),
    ),
  );
}

Widget heroUserListTile(
  BuildContext context, {
  int? id,
  required String name,
  String? photoId,
  String? token,
  String? type,
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: GREY,
            child: Hero(
              tag: '$id' + name,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 26,
                backgroundImage: (photoId == null
                    ? const AssetImage(
                        'assets/images/logo_image.png',
                      )
                    : NetworkImage(
                        '$BASE_PUBLIC_API/metaFiles/$photoId/view',
                        headers: {'Authorization': 'Basic $token'},
                      )) as ImageProvider<Object>?,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Text(name, style: context.textTheme.subtitle1)),
                  ],
                ),
                if (type != null)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          type,
                          style: context.textTheme.subtitle1!.copyWith(color: GREY, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
