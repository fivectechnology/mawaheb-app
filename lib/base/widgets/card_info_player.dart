import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

Widget cardInfoPlayer({BuildContext context, List<Widget> rows}) {
  return Card(
    elevation: 3,
    shadowColor: Colors.black87,
    margin: EdgeInsets.symmetric(
      horizontal: context.fullWidth * 0.05,
    ),
    child: Column(children: rows),
  );
}

Widget infoRow({BuildContext context, String title, String value}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: context.fullWidth * 0.04,
    ),
    child: ListTile(
      title: Text(
        context.translate(title),
        style: context.textTheme.subtitle1.copyWith(color: Colors.grey),
      ),
      subtitle: Text(value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.subtitle1),
    ),
  );
}
