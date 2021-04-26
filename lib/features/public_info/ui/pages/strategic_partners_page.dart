import 'package:core_sdk/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/features/public_info/data/models/strategic_partners_model.dart';
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

class _StrategicPartnersPageState extends ProviderMobxState<StrategicPartnersPage, PublicInfoViewmodel> {
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
        backgroundColor: WHITE,
        body: MawahebFutureBuilder<List<StrategicPartnersModel>>(
          future: viewmodel.partnersFuture,
          onRetry: viewmodel.getPartners,
          onSuccess: (partners) {
            return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                physics: const BouncingScrollPhysics(),
                itemCount: partners.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 26),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          partners[index].title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                        ),
                        const SizedBox(height: 7),
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                'http://54.237.125.179:8080/mawaheb/ws/rest/com.axelor.meta.db.MetaFile/${partners[index].source.id}/view',
                                headers: {'Authorization': 'Basic ${viewmodel.prefsRepository.token}'},
                                fit: BoxFit.fill,
                              )),
                        )
                      ],
                    ),
                  );
                });
          },
        ));
  }
}
