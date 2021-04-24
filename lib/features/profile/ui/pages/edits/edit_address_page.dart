import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:mawaheb_app/app/app.dart';
import 'package:mawaheb_app/app/base_page.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/utils/validators.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/data/models/emirate_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({
    Key key,
  }) : super(key: key);

  static MaterialPageRoute pageRoute(ProfileViewmodel profileViewmodel) =>
      MaterialPageRoute(
        builder: (context) => Provider.value(
          value: profileViewmodel,
          child: const EditAddressPage(),
        ),
      );

  static const String route = '/edit_address_info';

  @override
  _EditAddressPageState createState() => _EditAddressPageState();
}

class _EditAddressPageState
    extends ProviderMobxState<EditAddressPage, ProfileViewmodel> {
  TextEditingController stateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  EmirateModel currentEmirate;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    stateController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (viewmodel?.emirates == null) {
      viewmodel.getEmirates();
    }
    // stateController = TextEditingController(text: viewmodel.player.area);
    // addressController = TextEditingController(text: viewmodel.player.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      appBar: customAppBar(
          context: context,
          title: 'lbl_address',
          withTitle: true,
          onBackButton: () {
            App.navKey.currentState.context
                .pushNamedAndRemoveUntil(BasePage.route, (_) => false);
          }),
      body: MawahebFutureBuilder<List<EmirateModel>>(
          future: viewmodel.emirateFuture,
          onRetry: viewmodel.getEmirates,
          onSuccess: (emirate) {
            return Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 43, vertical: 30),
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
                      validator: (value) {
                        return stateValidator(context: context, value: value);
                      }, // onChanged: (value) {
                      //   stateController.text = value;
                      // },
                      textEditingController: stateController,
                      context: context,
                    ),
                    const SizedBox(height: 26),
                    MawahebTextField(
                      hintText: 'lbl_address',
                      hintColor: Colors.grey,
                      validator: (value) {
                        return addressValidator(context: context, value: value);
                      },
                      textEditingController: addressController,
                      // onChanged: (value) {
                      //   addressController.text = value;
                      // },
                      context: context,
                    ),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Observer(
                          builder: (_) {
                            return MawahebButton(
                              text: 'lbl_back',
                              textColor: Colors.black,
                              borderColor: Colors.black,
                              buttonColor: WHITE,
                              isLoading: viewmodel.playerLoading,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();

                                  viewmodel.editAddressInfo(
                                      emirateModel: currentEmirate ??
                                          viewmodel.player.emirate,
                                      address: addressController.text ??
                                          viewmodel.player.address,
                                      area: stateController.text ??
                                          viewmodel.player.area);
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
              ),
            );
          }),
    );
  }
}
