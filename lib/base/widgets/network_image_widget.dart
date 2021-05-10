import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_loader.dart';

Widget networkImageCached({String? sourceId, String? token}) {
  return CachedNetworkImage(
    placeholder: (context, url) => const Center(child: MawahebLoader()),
    imageUrl: '$BASE_PUBLIC_API/metaFiles/$sourceId/view',
    httpHeaders: {'Authorization': 'Basic $token'},
    fit: BoxFit.fill,
  );
}
