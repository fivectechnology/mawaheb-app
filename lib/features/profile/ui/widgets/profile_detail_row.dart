import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/features/public_info/data/models/source_model.dart';

Widget profileDetails({
  BuildContext context,
  String name,
  SourceModel photo,
  String token,
  bool isConfirmed,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 40, left: 16, right: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 52,
          backgroundColor: GREY,
          child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 45,
              backgroundImage: photo == null
                  ? const AssetImage(
                      'assets/images/logo_image.png',
                    )
                  : NetworkImage(
                      '$BASE_PUBLIC_API/metaFiles/${photo.fileUUID}/view',
                      headers: {'Authorization': 'Basic $token'},
                    )),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                name,
                textAlign: TextAlign.start,
                style: context.textTheme.headline3.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              if (isConfirmed) ...{
                const SizedBox(height: 7.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: GREEN, borderRadius: BorderRadius.circular(20.0)),
                      padding: const EdgeInsets.all(4.0),
                      child: const Icon(
                        Icons.check,
                        color: WHITE,
                        size: 16.0,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        context.translate('lbl_confirmed_player'),
                        textAlign: TextAlign.start,
                        style: context.textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ],
                )
              }
            ],
          ),
        )
      ],
    ),
  );
}
