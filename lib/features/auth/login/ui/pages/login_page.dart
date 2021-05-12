import 'package:core_sdk/utils/constants.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:core_sdk/utils/utils.dart';
import 'package:core_sdk/utils/widgets/unfucus_detector.dart';

// import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/app/viewmodels/app_viewmodel.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/forgot_password/ui/pages/forgot_password_page.dart';
import 'package:mawaheb_app/features/auth/register/ui/pages/register_page.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:mawaheb_app/base/utils/validators.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  static const String route = '/login';
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (context) => const LoginPage());

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ProviderMobxState<LoginPage, AuthViewmodel> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPassword = false;
  String type = 'PLAYER';
  final _formKey = GlobalKey<FormState>();
  late AppViewmodel appViewmodel;

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

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      child: Scaffold(
        key: LoginPage.scaffoldKey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false, //new line
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.08),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      bottom: 5,
                    ),
                    child: Text(
                      context.translate('lbl_welcome_to_mawaheb'),
                      style: context.textTheme.headline1!.copyWith(
                          fontSize: 26,
                          letterSpacing: 0.3,
                          foreground: Paint()..shader = linearGradient),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: SvgPicture.asset(
                      'assets/images/slogan.svg',
                    ),
                  ),
                  MawahebTextField(
                    context: context,
                    hintText: 'lbl_email',
                    validator: (value) {
                      return emailValidator(
                          context: context, email: value ?? '');
                    },
                    textEditingController: _userNameController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 26,
                    ),
                    child: MawahebTextField(
                      textEditingController: _passwordController,
                      context: context,
                      hintText: 'lbl_password',
                      validator: (value) {
                        return passwordValidator(
                            context: context, password: value ?? '');
                      },
                      isSuffixIcon: true,
                      useObscure: true,
                    ),
                  ),
                  mawhaebDropDown(
                      hint: context.translate('lbl_type'),
                      context: context,
                      value: 'PLAYER',
                      items: [
                        'PLAYER',
                        'CLUB',
                      ]
                          .map((e) => DropdownMenuItem(
                                child: Text(context.translate(e)),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (v) {
                        type = v;
                        print(type);
                      }),
                  const SizedBox(height: 26),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          viewmodel!.registerFuture = null;
                          context.navigator
                              .push(ForgotPasswordPage.pageRoute(viewmodel!));
                        },
                        child: Text(
                          context.translate('lbl_forget_password'),
                          style: context.textTheme.subtitle1!.copyWith(
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                              color: const Color(0xFF9F9F9F)),
                        ),
                      )
                    ],
                  ),
                  Observer(builder: (_) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: context.fullHeight * 0.05,
                        bottom: context.fullHeight * 0.04,
                      ),
                      child: MawahebGradientButton(
                        // enable: !_userNameController.text.isNullOrEmpty && !_passwordController.text.isNullOrEmpty,
                        isLoading: viewmodel?.loginLoading ?? false,
                        text: 'lbl_login',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            viewmodel?.login(
                              type: type,
                              userName: _userNameController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                        context: context,
                      ),
                    );
                  }),
                  MawahebGradientButton(
                    text: 'lbl_sign_up_player',
                    onPressed: () {
                      viewmodel?.forgetPasswordEmail = null;

                      context.navigator
                          .push(RegisterPage.pageRoute(viewmodel!));
                    },
                    context: context,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.language,
                          color: DARK_GREY,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          context.translate('lbl_switch_language_to'),
                          style:
                              textTheme?.bodyText1?.copyWith(color: DARK_GREY),
                        ),
                        const SizedBox(width: 16),
                        InkWell(
                          onTap: () {
                            appViewmodel.changeLanguage(
                              isArabic(context: context)
                                  ? LANGUAGE_ENGLISH
                                  : LANGUAGE_ARABIC,
                            );
                          },
                          child: Text(
                            isArabic(localizations: context.locale)
                                ? 'English'
                                : 'العربية',
                            style: textTheme?.bodyText1!.copyWith(
                                color: RED, fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
