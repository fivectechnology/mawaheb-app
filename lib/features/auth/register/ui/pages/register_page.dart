import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:core_sdk/utils/mobx/widgets/mobx_loading_page.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/viewmodels/app_viewmodel.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_loader.dart';
import 'package:mawaheb_app/features/auth/otp/ui/pages/otp_page.dart';
import 'package:mawaheb_app/features/auth/register/ui/pages/add_sport_page.dart';
import 'package:mawaheb_app/features/auth/register/ui/pages/address_info_page.dart';
import 'package:mawaheb_app/features/auth/register/ui/pages/player_info_page.dart';
import 'package:mawaheb_app/features/auth/register/ui/pages/sign_up_page.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key key,
  }) : super(key: key);

  static const String route = '/register';
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static final GlobalKey<State> keyLoader = GlobalKey<State>();

  static MaterialPageRoute pageRoute(AuthViewmodel authViewmodel) =>
      MaterialPageRoute(
        builder: (context) => Provider.value(
          value: authViewmodel,
          child: const RegisterPage(),
        ),
      );

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState
    extends ProviderMobxState<RegisterPage, AuthViewmodel> {
  final PageController _pageController = PageController(keepPage: true);
  AppViewmodel appViewmodel;

  String pageTitle = 'lbl_sign_up';
  VoidCallback onBackButton;
  List<Widget> pages1 = [
    const SignUpPage(),
    const OtpPage(),
    const PlayerInfoPage(),
    const AddressInfoPage(),
    const AddSportPage(),
  ];

  List<Widget> pages2 = [
    const PlayerInfoPage(),
    const AddressInfoPage(),
    const AddSportPage(),
  ];

  @override
  void initState() {
    super.initState();
    onBackButton = () => context.pop();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    addSideEffects([
      reaction((_) => viewmodel.registerSliderModel,
          (PageSliderModel sliderModel) {
        slidePage(sliderModel);
        viewmodel.registerSliderModel = null;
      }),
    ]);

    appViewmodel = Provider.of<AppViewmodel>(context, listen: false)
      ..refreshUserStatus();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MobxLoadingPage(
      viewmodel: viewmodel,
      loadingWidget: const Center(child: MawahebLoader()),
      child: Scaffold(
        key: RegisterPage.scaffoldKey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: customAppBar(
          context: context,
          title: context.translate(pageTitle),
          onBackButton: onBackButton,
          withTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38),
          child: Observer(builder: (_) {
            return PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (int pageIndex) => !appViewmodel.userRegested
                  ? changeTitle(pageIndex)
                  : changeTitle2(pageIndex),
              // children: viewmodel.prefsRepository.player == null ? pages1 : pages2,
              children: !appViewmodel.userRegested ? pages1 : pages2,
            );
          }),
        ),
      ),
    );
  }

  void changeTitle(int pageIndex) {
    String newTitle;
    switch (pageIndex) {
      case 0:
        onBackButton = () => context.pop();
        newTitle = 'lbl_sign_up';
        break;
      case 1:
        onBackButton = () => slidePage(const PageSliderBackwardModel());

        newTitle = 'lbl_otp';
        break;
      case 2:
        newTitle = 'lbl_personal_info';
        break;
      case 3:
        newTitle = 'lbl_address';
        break;
      case 4:
        newTitle = 'lbl_add_sport';
        break;
    }

    setState(() => pageTitle = newTitle);
  }

  void changeTitle2(int pageIndex) {
    print('ttttt2');
    print(!appViewmodel.userRegested);
    String newTitle;
    switch (pageIndex) {
      case 0:
        newTitle = 'lbl_personal_info';
        break;
      case 1:
        newTitle = 'lbl_address';
        break;
      case 2:
        newTitle = 'lbl_add_sport';
        break;
    }

    setState(() => pageTitle = newTitle);
  }

  void slidePage(PageSliderModel sliderModel) {
    if (sliderModel == null) {
      return;
    }
    sliderModel.value == 1
        ? _pageController.nextPage(
            duration: 400.milliseconds, curve: Curves.easeIn)
        : _pageController.previousPage(
            duration: 400.milliseconds, curve: Curves.easeOut);
  }
}
