import 'package:flutter/material.dart';
import 'package:mawaheb_app/features/public_info/data/models/source_model.dart';

Widget userListTile(
    {String name, SourceModel photo, String token, String type}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: ListTile(
      leading: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              alignment: Alignment.center,
              fit: BoxFit.fill,
              image: photo == null
                  ? const AssetImage(
                      'assets/images/profile.png',
                    )
                  : NetworkImage(
                      'http://54.237.125.179:8080/mawaheb/ws/rest/com.axelor.meta.db.MetaFile/${photo.id}/view',
                      headers: {'Authorization': 'Basic $token'},
                    )),
        ),
      ),
      title: Text(name),
      subtitle: type != null ? Text(type) : const SizedBox(),
    ),
  );
}
