import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

Widget imageRow({BuildContext context, String title, int idSource}) {
  return Padding(
    padding: const EdgeInsets.only(top: 26),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        ),
        const SizedBox(height: 5),
        ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              'http://54.237.125.179:8080/mawaheb/ws/rest/com.axelor.meta.db.MetaFile/$idSource/download2',
              // ignore: prefer_const_literals_to_create_immutables
              headers: {'Authorization': 'Basic YWRtaW46YWRtaW4='},
            )),
      ],
    ),
  );
}
