import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/app/viewmodels/app_viewmodel.dart';
import 'package:mawaheb_app/base/utils/app_bar_params.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatelessWidget {
  const WebPage(this.pageTitle, this.url, {Key key, this.showAppBar = true}) : super(key: key);

  final String pageTitle;
  final String url;
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    if (!showAppBar) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Provider.of<AppViewmodel>(context, listen: false).pushRoute(AppBarParams(
          title: pageTitle,
          showBackButton: true,
          translateTitle: false,
          onBackPressed: () => context.pop(),
        ));
      });
    }
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              centerTitle: false,
              backgroundColor: WHITE,
              automaticallyImplyLeading: false,
              leading: const CupertinoNavigationBarBackButton(color: TEXT_COLOR),
              title: Text(
                pageTitle,
                style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 18),
              ),
              elevation: 0.0,
            )
          : null,
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
