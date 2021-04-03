import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

class RenewSubscriptionPage extends StatefulWidget {
  const RenewSubscriptionPage({Key key}) : super(key: key);

  @override
  _RenewSubscriptionPageState createState() => _RenewSubscriptionPageState();
}

class _RenewSubscriptionPageState
    extends MobxState<RenewSubscriptionPage, ProfileViewmodel> {
  bool isAccepted = false;
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
      backgroundColor: Colors.white,
      appBar: customAppBar(
          context: context, withTitle: true, title: 'lbl_renew_subscription'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: context.fullHeight * 0.03),
              child: Card(
                  elevation: 3,
                  shadowColor: Colors.black87,
                  margin: EdgeInsets.symmetric(
                    horizontal: context.fullWidth * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      paymentRow(
                          title: 'lbl_choose_payment',
                          child: paymentDropDown(hint: 'Credit card')),
                      paymentRow(
                          title: 'lbl_card_number',
                          child: paymentTextField(hint: 'Card Number')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          paymentRow(
                              width: context.fullWidth * 0.3,
                              title: 'lbl_expiry_month',
                              child: paymentDropDown(hint: 'Credit card')),
                          paymentRow(
                              width: context.fullWidth * 0.3,
                              title: 'lbl_expiry_year',
                              child: paymentDropDown(hint: 'Credit card')),
                        ],
                      ),
                      paymentRow(
                          width: context.fullWidth * 0.3,
                          title: 'lbl_cvv_Number',
                          child: paymentTextField(hint: 'Card Number')),
                      paymentRow(
                          title: 'lbl_card_holder_name',
                          child: paymentTextField(hint: 'Card Number')),
                    ],
                  )),
            ),
            Card(
              elevation: 3,
              shadowColor: Colors.black87,
              margin: EdgeInsets.symmetric(
                horizontal: context.fullWidth * 0.05,
                vertical: context.fullWidth * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: InkWell(
                      onTap: () {
                        setState(() {
                          isAccepted = !isAccepted;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: context.fullHeight * 0.01),
                        height: context.fullWidth * 0.08,
                        width: context.fullWidth * 0.08,
                        decoration: BoxDecoration(
                            color: isAccepted ? YELLOW : Colors.white,
                            border:
                                Border.all(width: 2.0, color: Colors.black)),
                        child: Icon(
                          Icons.check,
                          color: isAccepted ? Colors.black : Colors.white,
                          size: 26,
                        ),
                      ),
                    ),
                    title: Text(
                      context.translate('msg_accepted'),
                      style: textTheme.bodyText2.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 12),
                    ),
                    subtitle: Text(
                      context.translate('lbl_term_of_service'),
                      style: textTheme.headline6
                          .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.fullWidth * 0.05,
                        vertical: context.fullHeight * 0.02),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'AED 400',
                          style: textTheme.headline2.copyWith(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        FlatButton(
                          minWidth: context.fullWidth * 0.2,
                          onPressed: () {},
                          color: YELLOW,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text(
                            context.translate('lbl_pay'),
                            style: textTheme.headline2.copyWith(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget paymentRow({String title, double width, Widget child}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.fullWidth * 0.05,
          vertical: context.fullHeight * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.translate(title),
              style: textTheme.subtitle1
                  .copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
          Container(
              width: width,
              margin: EdgeInsets.symmetric(vertical: context.fullHeight * 0.01),
              height: context.fullHeight * 0.07,
              color: Colors.grey[200],
              child: child)
        ],
      ),
    );
  }

  Widget paymentTextField({String hint}) {
    return TextField(
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.symmetric(horizontal: context.fullWidth * 0.02),
        hintText: hint,
        hintStyle:
            textTheme.subtitle1.copyWith(color: Colors.black54, fontSize: 12),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );
  }

  Widget paymentDropDown({String hint}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.02),
      child: DropdownButton(
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black87,
        ),
        isExpanded: true,
        underline: const SizedBox(),
        hint: Text(
          hint,
          style:
              textTheme.subtitle1.copyWith(color: Colors.black54, fontSize: 12),
        ),
        items: const [],
        onChanged: (value) {},
      ),
    );
  }
}
