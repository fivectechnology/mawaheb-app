import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({Key key}) : super(key: key);

  @override
  _VideosPageState createState() => _VideosPageState();
}

class _VideosPageState extends MobxState<VideosPage, ProfileViewmodel> {
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: YELLOW,
          child: const Icon(
            Icons.add,
            color: Colors.black87,
            size: 36,
          ),
        ),
        backgroundColor: Colors.white,
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return videoRow();
            }));
  }

  Widget videoRow() {
    return Padding(
      padding: EdgeInsets.only(bottom: context.fullHeight * 0.03),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.fullWidth * 0.04,
                vertical: context.fullHeight * 0.01),
            child: Row(
              children: [
                Image.asset('assets/icons/ic_approve.png'),
                SizedBox(
                  width: context.fullWidth * 0.02,
                ),
                Text(
                  'Approved',
                  style: textTheme.headline2.copyWith(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                margin:
                    EdgeInsets.symmetric(horizontal: context.fullWidth * 0.04),
                height: context.fullHeight * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: Colors.red),
              ),
              Padding(
                padding: EdgeInsets.only(right: context.fullWidth * 0.03),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
