import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/features/public_info/data/models/download_center_model.dart';
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

class _DownLoadCenterPageState extends ProviderMobxState<DownLoadCenterPage, PublicInfoViewmodel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (viewmodel?.downloads == null) {
      viewmodel.getDownloads();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.02),
        child: MawahebFutureBuilder<List<DownloadCenterModel>>(
            future: viewmodel.downloadsFuture,
            onRetry: viewmodel.getDownloads,
            onSuccess: (downloads) {
              return downloads == null
                  ? const SizedBox()
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.02),
                      itemCount: downloads.length,
                      itemBuilder: (context, index) {
                        return downloadButton(
                          fileName: viewmodel.prefsRepository.languageCode == 'en'
                              ? downloads[index].title
                              : downloads[index].titleAr,
                          onPress: () => viewmodel.downloadFile(
                            id: downloads[index].source.id,
                            parentId: downloads[index].id,
                          ),
                        );
                      });
            }),
      ),
    );
  }

  Widget downloadButton({String fileName, Function onPress}) {
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
              Expanded(child: Text(fileName, style: textTheme.bodyText1.copyWith(color: DARK_GREY)))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                // minWidth: context.fullWidth * 0.2,
                onPressed: onPress,
                color: YELLOW,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(
                  context.translate('lbl_download'),
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
