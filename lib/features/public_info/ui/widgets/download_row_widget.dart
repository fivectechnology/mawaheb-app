import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/widgets/network_image_widget.dart';

Widget imageRow({
  BuildContext context,
  String title,
  int idSource,
  String token,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 26),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        ),
        const SizedBox(height: 7.0),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: networkImageCached(sourceId: idSource, token: token),
          ),
        )
      ],
    ),
  );
}
