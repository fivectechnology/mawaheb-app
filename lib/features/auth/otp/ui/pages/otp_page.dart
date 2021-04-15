import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawaheb_app/app/base_page.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key key}) : super(key: key);

  static const String route = '/otp';

  static MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (context) => const OtpPage());

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends ProviderMobxState<OtpPage, AuthViewmodel> {
  final TextEditingController _otpController = TextEditingController();

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.fullHeight * 0.02,
            ),
            child: Text(
              context.translate('msg_enter_otp'),
              style: context.textTheme.headline1.copyWith(
                  color: Colors.black, fontSize: 22, wordSpacing: 0.5),
            )),
        Observer(builder: (_) {
          return Text(
            viewmodel?.player?.email ?? '',
            style: context.textTheme.bodyText1
                .copyWith(color: Colors.black, fontSize: 16),
          );
        }),
        SizedBox(
          height: context.fullHeight * 0.08,
        ),
        PinCodeTextField(
          autofocus: true,
          pinTextStyle: context.textTheme.headline2.copyWith(fontSize: 26),
          pinBoxDecoration: ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
          controller: _otpController,
        ),
        Padding(
            padding: EdgeInsets.only(
                top: context.fullHeight * 0.08,
                bottom: context.fullHeight * 0.04),
            child: Observer(
              builder: (_) {
                return MawahebButton(
                  onPressed: () {
                    viewmodel.sendOTP(email: viewmodel?.player?.email);
                    _otpBottomSheet(context, viewmodel?.player?.email);
                  },
                  context: context,
                  text: 'lbl_resend_otp',
                  buttonColor: Colors.white,
                  textColor: Colors.black,
                  borderColor: Colors.black,
                );
              },
            )),
        Observer(builder: (_) {
          return MawahebButton(
            onPressed: () {
              viewmodel.verifyOTP(
                  email: viewmodel?.player?.email,
                  code: int.parse(_otpController.text));
            },
            context: context,
            text: 'lbl_next',
            buttonColor: const Color(0xFF9F9F9F),
            textColor: Colors.white,
            borderColor: Colors.white,
          );
        }),
      ],
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
                  style:
                      context.textTheme.bodyText1.copyWith(color: Colors.grey),
                ),
                subtitle: Text(
                  email,
                  style:
                      context.textTheme.bodyText1.copyWith(color: Colors.black),
                ),
              ),
            ],
          );
        });
  }
}
