import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key key}) : super(key: key);

  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends MobxState<MyInfoPage, ProfileViewmodel> {
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
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.fullWidth * 0.07,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.translate('Sport'),
                    style: textTheme.subtitle1
                        .copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
                IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
                    onPressed: () {})
              ],
            ),
          ),
          Card(
            elevation: 3,
            shadowColor: Colors.black87,
            margin: EdgeInsets.symmetric(
              horizontal: context.fullWidth * 0.05,
            ),
            child: Column(
              children: [
                infoRow(title: 'lbl_sport_name', value: 'Football'),
                infoRow(title: 'lbl_position', value: 'Football'),
                infoRow(title: 'lbl_weight', value: 'Football'),
                infoRow(title: 'lbl_hight', value: 'Football'),
                infoRow(title: 'lbl_prefer_hand', value: 'Football'),
                infoRow(title: 'lbl_prefer_leg', value: 'Football'),
                infoRow(
                    title: 'lbl_brief',
                    value:
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc quis risus mi. Ut ….'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget infoRow({String title, String value}) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.fullWidth * 0.04,
      ),
      child: ListTile(
        title: Text(
          context.translate(title),
          style: textTheme.subtitle1.copyWith(color: Colors.grey),
        ),
        subtitle: Text(value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.subtitle1),
      ),
    );
  }
}
