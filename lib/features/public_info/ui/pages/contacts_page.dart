import 'package:flutter/material.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/features/public_info/data/models/contact_us_model.dart';
import 'package:mawaheb_app/features/public_info/viewmodels/public_info_viewmodels.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key key}) : super(key: key);

  static const String route = '/contacts';

  static MaterialPageRoute<dynamic> get pageRoute =>
      MaterialPageRoute<dynamic>(builder: (_) => const ContactsPage());

  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState
    extends ProviderMobxState<ContactsPage, PublicInfoViewmodel> {
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
    if (viewmodel?.contacts == null) {
      viewmodel.getcontactUs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.fullWidth * 0.05,
            vertical: context.fullHeight * 0.05),
        child: MawahebFutureBuilder<ContactUsModel>(
            future: viewmodel.contactsFuture,
            onRetry: viewmodel.getcontactUs,
            onSuccess: (contacts) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo_image.png'),
                  contactRow(title: 'Address: ', text: contacts.address),
                  contactRow(title: 'Email: ', text: contacts.email),
                  contactRow(title: 'Phone: ', text: contacts.phone),
                ],
              );
            }),
      ),
    );
  }

  Widget contactRow({String title, String text}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.fullHeight * 0.01),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: RichText(
                  text: TextSpan(
                    text: title,
                    style: textTheme.headline6.copyWith(fontSize: 14),
                    children: [
                      TextSpan(
                          text: text,
                          style: textTheme.subtitle2
                              .copyWith(fontWeight: FontWeight.w200)),
                    ],
                  ),
                ),
              ),
              // Text(
              //   title,
              //   style: textTheme.headline6.copyWith(fontSize: 14),
              // ),
              // Flexible(
              //   child: Text(
              //     text,
              //     style:
              //         textTheme.subtitle2.copyWith(fontWeight: FontWeight.w200),
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}
