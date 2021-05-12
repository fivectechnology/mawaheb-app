import 'package:flutter/material.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/features/public_info/data/models/gallery_model.dart';
import 'package:mawaheb_app/features/public_info/ui/widgets/download_row_widget.dart';
import 'package:mawaheb_app/features/public_info/viewmodels/public_info_viewmodels.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  static const String route = '/gallery';

  static MaterialPageRoute<dynamic> get pageRoute => MaterialPageRoute<dynamic>(builder: (_) => const GalleryPage());

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends ProviderMobxState<GalleryPage, PublicInfoViewmodel> {
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
    if (viewmodel?.gallery == null) {
      viewmodel?.getGallery();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: WHITE,
        body: MawahebFutureBuilder<List<GalleryModel>>(
            future: viewmodel?.galleryFuture,
            onRetry: viewmodel?.getGallery ?? () {},
            onSuccess: (gallery) {
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: gallery?.length,
                  itemBuilder: (context, index) {
                    return imageRow(
                        context: context,
                        token: viewmodel?.prefsRepository.token,
                        title: viewmodel?.prefsRepository.languageCode == 'en'
                            ? gallery![index].title!
                            : gallery![index].titleAr!,
                        sourceId: gallery[index].sourceId);
                  });
            }));
  }
}
