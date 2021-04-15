import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/data/models/emirate_model.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';

class AddressInfoPage extends StatefulWidget {
  const AddressInfoPage({
    Key key,
  }) : super(key: key);

  static MaterialPageRoute get pageRoute => MaterialPageRoute(builder: (context) => const AddressInfoPage());

  static const String route = '/address_info';

  @override
  _AddressInfoPageState createState() => _AddressInfoPageState();
}

class _AddressInfoPageState extends ProviderMobxState<AddressInfoPage, AuthViewmodel> {
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  EmirateModel currentEmirate;
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
    if (viewmodel?.emirates == null) {
      viewmodel.getEmirates();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(context: context, title: 'lbl_address', withTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 43, vertical: 26),
        child: MawahebFutureBuilder<List<EmirateModel>>(
            future: viewmodel.emirateFuture,
            onRetry: viewmodel.getEmirates,
            onSuccess: (emirate) {
              return Column(
                children: [
                  mawhaebDropDown(
                    hint: 'lbl_emirates',
                    context: context,
                    onChanged: (value) {
                      currentEmirate = value;
                    },
                    items: viewmodel.emirates
                        .map((em) => DropdownMenuItem(
                              child: Text(em.name),
                              value: em,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 26),
                  MawahebTextField(
                    hintText: 'lbl_state/province/area',
                    hintColor: Colors.grey,
                    textEditingController: _stateController,
                    context: context,
                  ),
                  const SizedBox(height: 26),
                  MawahebTextField(
                    hintText: 'lbl_address',
                    hintColor: Colors.grey,
                    textEditingController: _addressController,
                    context: context,
                  ),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: MawahebGradientButton(
                        text: 'lbl_next',
                        onPressed: () => viewmodel.addAddressInfo(
                            emirateModel: currentEmirate,
                            address: _addressController.text,
                            area: _addressController.text),
                        context: context,
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
