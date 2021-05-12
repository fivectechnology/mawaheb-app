import 'package:core_sdk/utils/constants.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:core_sdk/utils/widgets/loading_page.dart';
import 'package:core_sdk/utils/widgets/progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/app/viewmodels/app_viewmodel.dart';
import 'package:mawaheb_app/base/utils/api_helper.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_dialog.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_loader.dart';
import 'package:mawaheb_app/base/widgets/web_page.dart';
import 'package:mawaheb_app/features/settings/ui/change_email_page.dart';
import 'package:mawaheb_app/features/settings/ui/change_password_page.dart';
import 'package:mawaheb_app/features/settings/viewmodels/settings_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:supercharged/supercharged.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  static MaterialPageRoute<dynamic> get pageRoute => MaterialPageRoute<dynamic>(builder: (_) => const SettingsPage());

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends MobxState<SettingsPage, SettingsViewmodel> {
  // Lang _lang = Lang.english;
  bool noti = false;
  AppViewmodel? appViewmodel;

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
    appViewmodel = Provider.of<AppViewmodel>(context, listen: false);
  }

//(appViewmodel?.languageLoading ?? false)
  // ? const Center(
  //     child: MawahebLoader(),
  // )
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return LoadingPage(
          isLoading: appViewmodel?.languageLoading ?? false,
          loadingWidget: const Center(child: MawahebLoader()),
          child: Scaffold(
            key: viewmodel?.scaffoldKey,
            backgroundColor: Colors.white,
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Card(
                  elevation: 3.0,
                  shadowColor: Colors.black87,
                  margin: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 30.0),
                  child: Column(
                    children: [
                      // TODO(abd): add notification switcher here
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(context.translate('lbl_app_notification'),
                      //           style: textTheme.subtitle1.copyWith(
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.bold,
                      //           )),
                      //       mawahebSwitchButton(
                      //         isSelected: noti,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      settingRow(
                          text: 'lbl_change_password',
                          onPress: () {
                            context.navigator.push(ChangePasswordPage.cupertionPageRoute(viewmodel!));
                          }),
                      settingRow(
                          text: 'lbl_change_email',
                          onPress: () {
                            context.navigator.push(ChangeEmailPage.cupertionPageRoute(viewmodel!));
                          }),
                      settingRow(
                        text: 'lbl_term_of_service',
                        onPress: () {
                          context.cupertinoPushPage(WebPage(
                            context.translate('lbl_term_of_service'),
                            TERMS_OF_SERVICES_ENDPOINT,
                            showAppBar: false,
                          ));
                        },
                      ),
                      Observer(builder: (_) {
                        return settingRow(
                          text: 'lbl_log_out',
                          onPress: () {
                            mawahebShowConfirmDialog(
                                context: context,
                                message: context.translate('msg_app_exit_confirm'),
                                onConfirm: () {
                                  viewmodel?.logout();
                                });
                          },
                          isLoading: viewmodel?.logoutLoading ?? false,
                        );
                      }),
                    ],
                  ),
                ),
                Card(
                  elevation: 3,
                  shadowColor: Colors.black54,
                  margin: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 26.0),
                        child: Text(context.translate('lbl_language'),
                            style: textTheme!.subtitle1!.copyWith(fontSize: 14.0, fontWeight: FontWeight.bold)),
                      ),
                      RadioListTile(
                        title: Text(
                          'English',
                          style: textTheme!.subtitle1!.copyWith(fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                        activeColor: RED,
                        value: LANGUAGE_ENGLISH,
                        groupValue: appViewmodel?.language,
                        onChanged: (_) {
                          appViewmodel?.changeLanguage(LANGUAGE_ENGLISH, updateBackend: true);
                          // viewmodel?.updateUserLanguage(lang: v);
                        },
                      ),
                      RadioListTile(
                        title: Text(
                          'العربية',
                          style: textTheme!.subtitle1!.copyWith(fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                        activeColor: RED,
                        value: LANGUAGE_ARABIC,
                        groupValue: appViewmodel?.language,
                        onChanged: (_) {
                          appViewmodel?.changeLanguage(LANGUAGE_ARABIC, updateBackend: true);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget settingRow({
    required String text,
    VoidCallback? onPress,
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
              style: textTheme!.subtitle1!.copyWith(fontSize: 14.0, fontWeight: FontWeight.bold),
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
