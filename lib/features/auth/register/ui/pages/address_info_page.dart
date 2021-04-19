import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/data/models/emirate_model.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AddressInfoPage extends StatefulWidget {
  const AddressInfoPage({
    Key key,
  }) : super(key: key);

  static MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (context) => const AddressInfoPage());

  static const String route = '/address_info';

  @override
  _AddressInfoPageState createState() => _AddressInfoPageState();
}

class _AddressInfoPageState
    extends ProviderMobxState<AddressInfoPage, AuthViewmodel> {
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  EmirateModel currentEmirate;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _stateController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (viewmodel?.emirates == null) {
      viewmodel.getEmirates();
    }
  }

  String stateValidator(String value) {
    if (value.isEmpty) {
      return 'State is empty';
    }
    return null;
  }

  String addressValidator(String value) {
    if (value.isEmpty) {
      return 'Address is empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MawahebFutureBuilder<List<EmirateModel>>(
        future: viewmodel.emirateFuture,
        onRetry: viewmodel.getEmirates,
        onSuccess: (emirate) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                mawhaebDropDown(
                  hint: 'lbl_emirate',
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
                  validator: stateValidator,
                  textEditingController: _stateController,
                  context: context,
                ),
                const SizedBox(height: 26),
                MawahebTextField(
                  hintText: 'lbl_address',
                  hintColor: Colors.grey,
                  validator: addressValidator,
                  textEditingController: _addressController,
                  context: context,
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Observer(
                      builder: (_) {
                        return MawahebGradientButton(
                          text: 'lbl_next',
                          isLoading: viewmodel.registerLoading,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              viewmodel.addAddressInfo(
                                  emirateModel: currentEmirate,
                                  address: _addressController.text,
                                  area: _addressController.text);
                            }
                          },
                          context: context,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 34),
              ],
            ),
          );
        });
  }
}
