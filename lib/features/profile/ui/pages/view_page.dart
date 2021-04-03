import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

class ViewsPage extends StatefulWidget {
  const ViewsPage({Key key}) : super(key: key);

  @override
  _ViewsPageState createState() => _ViewsPageState();
}

class _ViewsPageState extends MobxState<ViewsPage, ProfileViewmodel> {
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
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: context.fullHeight * 0.04,
                  left: context.fullWidth * 0.06),
              child: Text(context.translate('Clubs view profile'),
                  style: textTheme.subtitle1
                      .copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
            ),
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: Image.asset(
                        'assets/images/profile.png',
                      ),
                    ),
                    title: Text('Club name'),
                    subtitle: Text('Club'),
                  );
                })
          ],
        ),
      ),
    );
  }
}
