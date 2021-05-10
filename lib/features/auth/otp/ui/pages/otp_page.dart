import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:mobx/mobx.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  static const String route = '/otp';
  // static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static MaterialPageRoute pageRoute(AuthViewmodel authViewmodel) => MaterialPageRoute(
        builder: (context) => Provider.value(
          value: authViewmodel,
          child: const OtpPage(),
        ),
      );

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends ProviderMobxState<OtpPage, AuthViewmodel> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode()..requestFocus();

  @override
  void initState() {
    super.initState();
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                  vertical: context.fullHeight * 0.02,
                ),
                child: Text(
                  context.translate('msg_enter_otp'),
                  style: context.textTheme.headline1!.copyWith(color: Colors.black, fontSize: 22, wordSpacing: 0.5),
                )),
            Observer(builder: (_) {
              return Text(
                viewmodel.forgetPasswordEmail ?? '',
                style: context.textTheme.bodyText1!.copyWith(color: Colors.black, fontSize: 16),
              );
            }),
            Observer(builder: (_) {
              return Text(
                viewmodel.player?.email ?? '',
                style: context.textTheme.bodyText1!.copyWith(color: Colors.black, fontSize: 16),
              );
            }),
            SizedBox(
              height: context.fullHeight * 0.08,
            ),
            Observer(builder: (_) {
              return Text(
                viewmodel.otpCodeMessage ?? '',
                style: context.textTheme.bodyText1!.copyWith(color: Colors.black, fontSize: 16),
              );
            }),
            SizedBox(
              height: context.fullHeight * 0.08,
            ),

            codeField(true),
            Padding(
              padding: EdgeInsets.only(
                top: context.fullHeight * 0.08,
                bottom: context.fullHeight * 0.04,
              ),
              child: MawahebButton(
                onPressed: () => viewmodel.sendOTP(
                  resend: true,
                  email: viewmodel.forgetPasswordEmail ?? viewmodel.player?.email,
                ),
                // _otpBottomSheet(context, viewmodel.player?.email ?? '');

                context: context,
                text: 'lbl_resend_otp',
                buttonColor: Colors.white,
                textColor: Colors.black,
                borderColor: Colors.black,
              ),
            ),
            // Observer(builder: (_) {
            //   return MawahebButton(
            //     onPressed: () =>
            //         viewmodel.verifyOTP(email: viewmodel.player?.email, code: int.parse(_otpController.text)),
            //     context: context,
            //     text: 'lbl_next',
            //     buttonColor: const Color(0xFF9F9F9F),
            //     textColor: Colors.white,
            //     borderColor: Colors.white,
            //   );
            // }),
          ],
        ),
      ),
    );
  }

  void _otpBottomSheet(BuildContext context, String email) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                leading: SvgPicture.asset('assets/icons/ic_otp.svg'),
                title: Text(
                  context.translate('msg_check_otp'),
                  style: context.textTheme.bodyText1!.copyWith(color: Colors.grey),
                ),
                subtitle: Text(
                  email,
                  style: context.textTheme.bodyText1!.copyWith(color: Colors.black),
                ),
              ),
            ],
          );
        });
  }

  void verifyCode(String code) {
    print('my deubg enter verifyCode $code ${viewmodel.player}');
    if (viewmodel.registerFuture == null) {
      viewmodel.verifyOTPPassword(code: code.toInt());
    } else {
      viewmodel.verifyOTP(code: code.toInt());
    }

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
        pinBoxColor: Colors.green[100]!,
        pinTextAnimatedSwitcherDuration: const Duration(milliseconds: 200),
        highlightAnimationBeginColor: Colors.black,
        highlightAnimationEndColor: Colors.white12,
        keyboardType: TextInputType.number,
      ),
    );
  }
}
