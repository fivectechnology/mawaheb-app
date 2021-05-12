import 'package:core_sdk/utils/extensions/list.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:core_sdk/utils/pagination_mixin.dart';
import 'package:core_sdk/utils/widgets/pagination_list.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/data/models/list_base_response_model.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/base/widgets/user_list_tile.dart';
import 'package:mawaheb_app/features/notifications/data/models/notification_model.dart';
import 'package:mawaheb_app/features/profile/data/models/view_model.dart';
import 'package:mawaheb_app/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

class ViewsPage extends StatefulWidget {
  const ViewsPage({Key? key}) : super(key: key);

  static MaterialPageRoute<dynamic> get pageRoute => MaterialPageRoute<dynamic>(builder: (_) => const ViewsPage());

  @override
  _ViewsPageState createState() => _ViewsPageState();
}

class _ViewsPageState extends ProviderMobxState<ViewsPage, ProfileViewmodel> with PaginationMixin {
  @override
  void initState() {
    super.initState();
    initPagination();
  }

  @override
  void dispose() {
    disposePagination();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (viewmodel?.views == null) {
      viewmodel?.playerViews(fresh: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MawahebFutureBuilder<ListBaseResponseModel<ViewModel>>(
      future: viewmodel?.viewsFuture,
      onRetry: viewmodel?.playerViews ?? () {},
      onSuccess: (ListBaseResponseModel<ViewModel>? views) {
        return PaginationList<ViewModel>(
          canLoadMore: viewmodel?.canLoadMoreViews ?? false,
          dataList: views?.data ?? [],
          scrollController: scrollController,
          shrinkWrap: false,
          padding: 4.0,
          emptyWidget: Center(child: Text(context.translate('msg_no_views'))),
          cardBuilder: (view) => heroUserListTile(
            context,
            id: view.partner?.id,
            name: view.partner!.name!,
            type: view.type,
            photoId: view.photoId,
            token: viewmodel?.prefsRepository.token,
          ),
        );
      },
    );
  }

  @override
  void onLoadMore() => viewmodel?.playerViews(fresh: true);

  // @override
  // Widget build(BuildContext context) {
  //   return MawahebFutureBuilder<List<ViewModel>>(
  //     future: viewmodel.viewsFuture,
  //     onRetry: viewmodel.playerViews,
  //     onSuccess: (List<ViewModel>? views) {
  //       return SingleChildScrollView(
  //         physics: const BouncingScrollPhysics(),
  //         child: Container(
  //           color: Colors.white,
  //           child: views != null && !views.isNullOrEmpty
  //               ? Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.all(26),
  //                       child: Text(context.translate('lbl_clubs_view'),
  //                           style: textTheme.subtitle1!.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
  //                     ),
  //                     ListView.builder(
  //                         physics: const NeverScrollableScrollPhysics(),
  //                         shrinkWrap: true,
  //                         itemCount: viewmodel.views!.length,
  //                         itemBuilder: (context, index) {
  //                           return userListTile(
  //                               name: viewmodel.views![index].partner!.name!,
  //                               type: viewmodel.views![index].type,
  //                               photoId: viewmodel.views![index].photoId,
  //                               token: viewmodel.prefsRepository.token);
  //                         })
  //                   ],
  //                 )
  //               : Center(
  //                   heightFactor: 10,
  //                   child: Text(
  //                     context.translate('msg_no_views'),
  //                     style: textTheme.subtitle1,
  //                   ),
  //                 ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
