import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';

Widget networkImageCached({int sourceId, String token}) {
  return CachedNetworkImage(
    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
    imageUrl: '$BASE_REST_API/com.axelor.meta.db.MetaFile/$sourceId/view',
    httpHeaders: {'Authorization': 'Basic $token'},
    fit: BoxFit.fill,
  );
}
