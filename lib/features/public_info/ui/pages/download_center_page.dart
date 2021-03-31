import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

import 'package:mawaheb_app/features/public_info/viewmodels/public_info_viewmodels.dart';

class DownLoadCenterPage extends StatefulWidget {
  const DownLoadCenterPage({Key key}) : super(key: key);

  static const String route = '/download_center';

  static MaterialPageRoute<dynamic> get pageRoute =>
      MaterialPageRoute<dynamic>(builder: (_) => const DownLoadCenterPage());

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  _DownLoadCenterPageState createState() => _DownLoadCenterPageState();
}

class _DownLoadCenterPageState
    extends MobxState<DownLoadCenterPage, PublicInfoViewmodel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.02),
        child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.02),
            itemCount: 3,
            itemBuilder: (context, index) {
              return downloadButton();
            }),
      ),
    );
  }

  Widget downloadButton({String text}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.01),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/icons/ic_download.png',
              ),
              const SizedBox(width: 10),
              Text('Aenean sed lorem est. Sed quis neque ',
                  style: textTheme.subtitle1.copyWith(fontSize: 16))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                minWidth: context.fullWidth * 0.2,
                onPressed: () {},
                color: YELLOW,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(
                  'Download',
                  style: textTheme.headline6,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
