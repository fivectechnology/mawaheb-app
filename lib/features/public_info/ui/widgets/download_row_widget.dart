import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/widgets/network_image_widget.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

Widget imageRow(
    {BuildContext context, String title, int idSource, String token}) {
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
            child: networkImageCached(sourceId: idSource, token: token))
      ],
    ),
  );
}
