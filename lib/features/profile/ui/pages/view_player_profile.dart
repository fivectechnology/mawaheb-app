import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/features/players/ui/pages/videos_page.dart';
import 'package:mawaheb_app/features/profile/ui/widgets/profile_detail_row.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

import 'my_info_page.dart';

class ViewPlayerProfile extends StatefulWidget {
  const ViewPlayerProfile({Key key}) : super(key: key);

  @override
  _ViewPlayerProfileState createState() => _ViewPlayerProfileState();
}

class _ViewPlayerProfileState extends State<ViewPlayerProfile>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, withTitle: false),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          profileDetails(context: context),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: context.fullHeight * 0.07,
            decoration: BoxDecoration(
              color: GREY,
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                color: YELLOW,
              ),
              tabs: [
                Text(
                  context.translate('lbl_personal_info'),
                ),
                Text(
                  context.translate('lbl_videos'),
                ),
              ],
              unselectedLabelColor: Colors.black,
              labelColor: Colors.black,
              labelStyle: context.textTheme.bodyText1,
              // labelPadding:
              //     const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              controller: _tabController,
            ),
          ),
          const SizedBox(height: 26),
          Expanded(
            child: TabBarView(controller: _tabController, children: const [
              MyInfoPage(),
              VideosPage(),
            ]),
          )
        ],
      ),
    );
  }
}
