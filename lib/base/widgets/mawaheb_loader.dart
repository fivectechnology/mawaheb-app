import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mawaheb_app/app/theme/colors.dart';

class MawahebLoader extends StatelessWidget {
  const MawahebLoader({Key? key, this.color}) : super(key: key);

  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SpinKitThreeBounce(color: color ?? PRIMARY, size: 24.0),
      ],
    );
  }
}
