import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:core_sdk/utils/widgets/progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/features/settings/ui/change_email_page.dart';
import 'package:mawaheb_app/features/settings/ui/change_password_page.dart';
import 'package:mawaheb_app/features/settings/ui/widgets/switch_button.dart';
import 'package:mawaheb_app/features/settings/viewmodels/settings_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:supercharged/supercharged.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key key,
  }) : super(key: key);

  static MaterialPageRoute<dynamic> get pageRoute =>
      MaterialPageRoute<dynamic>(builder: (_) => const SettingsPage());

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends MobxState<SettingsPage, SettingsViewmodel> {
  Lang _lang = Lang.english;

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
      key: viewmodel.scaffoldKey,
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Card(
            elevation: 3,
            shadowColor: Colors.black87,
            margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.translate('lbl_app_notification'),
                          style: textTheme.subtitle1.copyWith(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      const NotificationButton(),
                    ],
                  ),
                ),
                settingRow(
                    text: 'lbl_change_password',
                    onPress: () {
                      context.navigator
                          .push(ChangePasswordPage.pageRoute(viewmodel));
                    }),
                settingRow(
                    text: 'lbl_change_email',
                    onPress: () {
                      context.navigator
                          .push(ChangeEmailPage.pageRoute(viewmodel));
                    }),
                settingRow(text: 'lbl_term_of_service'),
                Observer(builder: (_) {
                  return settingRow(
                    text: 'lbl_log_out',
                    onPress: viewmodel.logout,
                    isLoading: viewmodel.logoutLoading,
                  );
                }),
              ],
            ),
          ),
          Card(
            elevation: 3,
            shadowColor: Colors.black54,
            margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
                  child: Text(context.translate('lbl_language'),
                      style: textTheme.subtitle1
                          .copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                RadioListTile(
                  title: Text('English',
                      style: textTheme.subtitle1
                          .copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
                  activeColor: RED,
                  value: Lang.english,
                  groupValue: _lang,
                  onChanged: (Lang value) {
                    setState(() {
                      _lang = value;
                    });
                  },
                ),
                RadioListTile(
                  title: Text('العربية',
                      style: textTheme.subtitle1
                          .copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
                  activeColor: RED,
                  value: Lang.arabic,
                  groupValue: _lang,
                  onChanged: (Lang value) {
                    setState(() {
                      _lang = value;
                    });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget settingRow({
    String text,
    VoidCallback onPress,
    bool isLoading = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15.0),
      child: InkWell(
        onTap: isLoading ? null : onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.translate(text),
              style: textTheme.subtitle1
                  .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            AnimatedSwitcher(
              duration: 400.milliseconds,
              child: isLoading
                  ? ProgressBar(color: PRIMARY)
                  : Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[400],
                      size: 14,
                    ),
            )
          ],
        ),
      ),
    );
  }
}

enum Lang { english, arabic }
