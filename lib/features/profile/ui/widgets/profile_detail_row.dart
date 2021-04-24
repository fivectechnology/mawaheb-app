import 'package:core_sdk/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawaheb_app/features/public_info/data/models/source_model.dart';

Widget profileDetails(
    {BuildContext context,
    String name,
    SourceModel photo,
    String token,
    bool isConfirmed}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, bottom: 40, left: 16, right: 16),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 52,
          backgroundColor: GREY,
          child: CircleAvatar(
              radius: 45,
              backgroundImage: photo == null
                  ? const AssetImage(
                      'assets/images/profile.png',
                    )
                  : NetworkImage(
                      'http://54.237.125.179:8080/mawaheb/ws/rest/com.axelor.meta.db.MetaFile/${photo.id}/view',
                      headers: {'Authorization': 'Basic $token'},
                    )),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: context.textTheme.headline3
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            if (isConfirmed)
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/ic_otp.svg',
                    height: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    context.translate('lbl_confirmed_player'),
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyText1
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              )
          ],
        )
      ],
    ),
  );
}
