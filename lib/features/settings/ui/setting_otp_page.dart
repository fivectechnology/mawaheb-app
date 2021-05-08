import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:core_sdk/utils/mobx/widgets/mobx_loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/app/viewmodels/app_viewmodel.dart';
import 'package:mawaheb_app/base/utils/app_bar_params.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_loader.dart';
import 'package:mawaheb_app/features/settings/viewmodels/settings_viewmodel.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:mobx/mobx.dart';
import 'package:supercharged/supercharged.dart';

class SettingOtpPage extends StatefulWidget {
  const SettingOtpPage({Key key}) : super(key: key);

  static const String route = '/setting_otp';
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static MaterialPageRoute pageRoute(SettingsViewmodel settingsViewmodel) => MaterialPageRoute(
        builder: (context) => Provider.value(
          value: settingsViewmodel,
          child: const SettingOtpPage(),
        ),
      );

  @override
  _SettingOtpPageState createState() => _SettingOtpPageState();
}

class _SettingOtpPageState extends ProviderMobxState<SettingOtpPage, SettingsViewmodel> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode()..requestFocus();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppViewmodel>(context, listen: false).pushRoute(AppBarParams(
        title: 'lbl_otp',
        showBackButton: true,
        onBackPressed: () => context.pop(),
      ));
    });
  }

  @override
  void dispose() {
    otpFocusNode.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    addSideEffects([
      reaction((_) => viewmodel.otpVerifyError, (bool isError) {
        setState(() {
          if (isError != null && isError) {
            _otpController.text = '';
            otpFocusNode.requestFocus();
          }
        });
      }),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MobxLoadingPage(
      viewmodel: viewmodel,
      loadingWidget: const Center(child: MawahebLoader()),
      child: Scaffold(
        backgroundColor: WHITE,
        key: SettingOtpPage.scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.fullHeight * 0.02,
                  ),
                  child: Text(
                    context.translate('msg_enter_otp'),
                    style: context.textTheme.headline1.copyWith(color: Colors.black, fontSize: 22, wordSpacing: 0.5),
                  )),
              Observer(builder: (_) {
                return Text(
                  viewmodel?.player?.email ?? '',
                  style: context.textTheme.bodyText1.copyWith(color: Colors.black, fontSize: 16),
                );
              }),
              SizedBox(
                height: context.fullHeight * 0.08,
              ),
              Observer(builder: (_) {
                return Text(
                  viewmodel?.otpCodeMessage ?? '',
                  style: context.textTheme.bodyText1.copyWith(color: Colors.black, fontSize: 16),
                );
              }),
              SizedBox(
                height: context.fullHeight * 0.08,
              ),
              codeField(true),
              Padding(
                padding: EdgeInsets.only(
                    left: 38, right: 38, top: context.fullHeight * 0.08, bottom: context.fullHeight * 0.04),
                child: MawahebButton(
                  onPressed: () => viewmodel.sendOTP(resend: true),
                  context: context,
                  text: 'lbl_resend_otp',
                  buttonColor: Colors.white,
                  textColor: Colors.black,
                  borderColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void verifyCode(String code) {
    print('my deubg enter verifyCode $code ${viewmodel?.player}');

    viewmodel.verifyOTP(code: code.toInt());
    FocusScope.of(context).unfocus();
  }

  Widget codeField(bool validation) {
    return Center(
      child: PinCodeTextField(
        autofocus: true,
        controller: _otpController,
        hideCharacter: false,
        highlight: true,
        highlightColor: PRIMARY,
        defaultBorderColor: DARK_GREY,
        hasTextBorderColor: validation ? PRIMARY : Colors.red,
        pinBoxWidth: MediaQuery.of(context).size.width / 10,
        pinBoxOuterPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        maxLength: 4,
        hasError: false,
        maskCharacter: '●',
        focusNode: otpFocusNode,
        onTextChanged: (_) {
          // setState(() {});
        },
        onDone: verifyCode,
        wrapAlignment: WrapAlignment.center,
        pinBoxDecoration: ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
        pinTextStyle: const TextStyle(
          fontSize: 18.0,
          color: DARK_GREY,
          fontWeight: FontWeight.w600,
        ),
        pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
        pinBoxColor: Colors.green[100],
        pinTextAnimatedSwitcherDuration: const Duration(milliseconds: 200),
        highlightAnimationBeginColor: Colors.black,
        highlightAnimationEndColor: Colors.white12,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
