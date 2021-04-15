import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/features/auth/otp/ui/pages/otp_page.dart';
import 'package:mawaheb_app/features/auth/register/ui/pages/add_sport_page.dart';
import 'package:mawaheb_app/features/auth/register/ui/pages/address_info_page.dart';
import 'package:mawaheb_app/features/auth/register/ui/pages/player_info_page.dart';
import 'package:mawaheb_app/features/auth/register/ui/pages/sign_up_page.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key key,
  }) : super(key: key);

  static const String route = '/register';
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

  String pageTitle = 'lbl_sign_up';
  VoidCallback onBackButton;

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
      }),
    ]);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (int pageIndex) => changeTitle(pageIndex),
          children: const [
            SignUpPage(),
            // OtpPage(),
            PlayerInfoPage(),
            AddressInfoPage(),
            AddSportPage(),
          ],
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

  // TODO(ahmad): put this in seperate file
  // Widget setp1(BuildContext context) {
  //   return SingleChildScrollView(
  //     child: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 42),
  //           child: MawahebTextField(
  //             context: context,
  //             hintText: 'lbl_name',
  //             textEditingController: _userNameController,
  //           ),
  //         ),
  //         MawahebTextField(
  //             context: context,
  //             hintText: 'lbl_email',
  //             textEditingController: _emailController),
  //         Padding(
  //           padding: const EdgeInsets.only(top: 45, bottom: 70),
  //           child: MawahebTextField(
  //             context: context,
  //             hintText: 'lbl_password',
  //             textEditingController: _passwordController,
  //             isSuffixIcon: true,
  //             useObscure: true,
  //           ),
  //         ),
  //         Observer(builder: (_) {
  //           return MawahebGradientButton(
  //             context: context,
  //             text: 'lbl_sign_up',
  //             isLoading: viewmodel.registerLoading,
  //             // onPressed: () => viewmodel.signUp(
  //             //   username: _userNameController.text,
  //             //   email: _emailController.text,
  //             //   password: _passwordController.text,
  //             // ),
  // TODO(ahmad): use this for test
  //             onPressed: () => slidePage(const PageSliderForawardModel()),
  //           );
  //         })
  //       ],
  //     ),
  //   );
  // }
}
