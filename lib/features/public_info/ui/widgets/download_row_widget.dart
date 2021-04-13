import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

Widget imageRow({BuildContext context, String title, String image}) {
  return Padding(
    padding: EdgeInsets.only(top: context.fullHeight * 0.05),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            'assets/images/gallery_image.png',
            width: context.fullWidth,
          ),
        ),
      ],
    ),
  );
}
