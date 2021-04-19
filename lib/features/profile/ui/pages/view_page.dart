import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/base/widgets/user_list_tile.dart';
import 'package:mawaheb_app/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

class ViewsPage extends StatefulWidget {
  const ViewsPage({Key key}) : super(key: key);

  static MaterialPageRoute<dynamic> get pageRoute =>
      MaterialPageRoute<dynamic>(builder: (_) => const ViewsPage());

  @override
  _ViewsPageState createState() => _ViewsPageState();
}

class _ViewsPageState extends ProviderMobxState<ViewsPage, ProfileViewmodel> {
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
    if (viewmodel?.views == null) {
      viewmodel.playerViews();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MawahebFutureBuilder(
      future: viewmodel.viewsFuture,
      onRetry: viewmodel.playerViews,
      onSuccess: (view) {
        return SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(26),
                  child: Text(context.translate('Clubs view profile'),
                      style: textTheme.subtitle1
                          .copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: viewmodel.views.length,
                    itemBuilder: (context, index) {
                      return userListTile(
                          name: viewmodel.views[index].partner.name);
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
