import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/features/public_info/data/models/strategic_partners_model.dart';
import 'package:mawaheb_app/features/public_info/ui/widgets/download_row_widget.dart';
import 'package:mawaheb_app/features/public_info/viewmodels/public_info_viewmodels.dart';

class StrategicPartnersPage extends StatefulWidget {
  const StrategicPartnersPage({Key key}) : super(key: key);

  static const String route = '/strategic_partners';

  static MaterialPageRoute<dynamic> get pageRoute =>
      MaterialPageRoute<dynamic>(builder: (_) => const StrategicPartnersPage());

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  _StrategicPartnersPageState createState() => _StrategicPartnersPageState();
}

class _StrategicPartnersPageState
    extends ProviderMobxState<StrategicPartnersPage, PublicInfoViewmodel> {
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
    if (viewmodel?.partners == null) {
      viewmodel.getPartners();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MawahebFutureBuilder<List<StrategicPartnersModel>>(
            future: viewmodel.partnersFuture,
            onRetry: viewmodel.getPartners,
            onSuccess: (partners) {
              return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: partners.length,
                  itemBuilder: (context, index) {
                    return imageRow(
                        context: context, title: partners[index].title);
                  });
            }));
  }
}
