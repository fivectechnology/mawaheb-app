import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget networkImageCached({int sourceId, String token}) {
  return CachedNetworkImage(
    placeholder: (context, url) => const CircularProgressIndicator(),
    imageUrl:
        'http://54.237.125.179:8080/mawaheb/ws/rest/com.axelor.meta.db.MetaFile/$sourceId/view',
    httpHeaders: {'Authorization': 'Basic $token'},
  );
}
