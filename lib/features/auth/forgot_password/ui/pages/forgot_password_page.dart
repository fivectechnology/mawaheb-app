import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:core_sdk/utils/mobx/widgets/mobx_loading_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/utils/validators.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_loader.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/forgot_password/ui/pages/reset_password_page.dart';
import 'package:mawaheb_app/features/auth/otp/ui/pages/otp_page.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  static const String route = '/forgot_password';
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static MaterialPageRoute pageRoute(AuthViewmodel authViewmodel) =>
      MaterialPageRoute(
        builder: (context) => Provider.value(
          value: authViewmodel,
          child: const ForgotPasswordPage(),
        ),
      );

  static CupertinoPageRoute cupertionPageRoute(AuthViewmodel? authViewmodel) =>
      CupertinoPageRoute(
        builder: (context) => Provider.value(
          value: authViewmodel,
          child: const ForgotPasswordPage(),
        ),
      );

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState
    extends ProviderMobxState<ForgotPasswordPage, AuthViewmodel> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController(keepPage: true);
  VoidCallback? onBackButton;
  String? pageTitle = 'lbl_sign_up';
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    onBackButton = () => context.pop();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    pages = [
      page1(),
      const OtpPage(),
      const ResetPasswordPagee(),
    ];
    addSideEffects([
      reaction((_) => viewmodel?.forgotPasswordSliderModel,
          (PageSliderModel? sliderModel) {
        slidePage(sliderModel);
        viewmodel?.forgotPasswordSliderModel = null;
      }),
    ]);
  }

  void changeTitle(int pageIndex) {
    String? newTitle;
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
        newTitle = 'lbl_Reset_password';
        break;
    }

    setState(() => pageTitle = newTitle);
  }

  void slidePage(PageSliderModel? sliderModel) {
    if (sliderModel == null) {
      return;
    }
    sliderModel.value == 1
        ? _pageController.nextPage(
            duration: 400.milliseconds, curve: Curves.easeIn)
        : _pageController.previousPage(
            duration: 400.milliseconds, curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return MobxLoadingPage(
      viewmodel: viewmodel!,
      loadingWidget: const Center(child: MawahebLoader()),
      child: Scaffold(
        key: ForgotPasswordPage.scaffoldKey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: customAppBar(
          context: context,
          title: context.translate(pageTitle!),
          onBackButton: onBackButton,
          withTitle: true,
        ) as PreferredSizeWidget?,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38),
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int pageIndex) => changeTitle(pageIndex),
            children: pages,
          ),
        ),
        // body: Padding(
        //   padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.08),
        //   child:
        // ),
      ),
    );
  }

  Widget page1() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(
                  top: context.fullHeight * 0.02,
                  bottom: context.fullHeight * 0.1),
              child: Text(
                context.translate('msg_recover_account'),
                style: context.textTheme.headline2!
                    .copyWith(color: Colors.black, fontSize: 40),
              )),
          MawahebTextField(
            hintText: 'lbl_email_username',
            hintColor: Colors.grey,
            validator: (value) {
              return emailValidator(context: context, email: value ?? '');
            },
            context: context,
            textEditingController: _emailController,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.1),
            child: MawahebButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  viewmodel?.forgetPasswordEmail = _emailController.text;
                  viewmodel?.forgetPassword(email: _emailController.text);
                }
              },
              context: context,
              text: 'lbl_next',
              buttonColor: Colors.white,
              textColor: Colors.black,
              borderColor: Colors.black,
              isLoading: viewmodel?.forgetPasswordLoading ?? false,
              progressColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
