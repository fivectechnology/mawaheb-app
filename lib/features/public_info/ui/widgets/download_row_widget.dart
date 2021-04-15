import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

Widget imageRow({BuildContext context, String title, String image}) {
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
          child: Image.asset(
            'assets/images/gallery_image.png',
            width: context.fullWidth,
          ),

          //           Image.network(
          //                 'http://54.237.125.179:8080/mawaheb/ws/rest/com.axelor.meta.db.MetaFile/4/content/download?v=0')
        ),
      ],
    ),
  );
}
