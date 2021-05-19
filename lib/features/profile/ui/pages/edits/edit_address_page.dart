import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';

import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/utils/validators.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/data/models/emirate_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/profile/viewmodels/edit_address_viewmodel.dart';

import 'package:core_sdk/utils/extensions/build_context.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({Key? key, this.player}) : super(key: key);

  // static MaterialPageRoute pageRoute(ProfileViewmodel profileViewmodel) =>
  //     MaterialPageRoute(
  //       builder: (context) => Provider.value(
  //         value: profileViewmodel,
  //         child: const EditAddressPage(),
  //       ),
  //     );

  final PlayerModel? player;
  // static MaterialPageRoute<dynamic> get pageRoute =>
  //     MaterialPageRoute<dynamic>(builder: (_) => const EditAddressPage());

  @override
  _EditAddressPageState createState() => _EditAddressPageState();
}

class _EditAddressPageState extends MobxState<EditAddressPage, EditAddressViewmodel> {
  TextEditingController stateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  EmirateModel? currentEmirate;

  @override
  void initState() {
    super.initState();
    if (viewmodel.player == null) {
      viewmodel.fetchPlayer(id: viewmodel.prefsRepository.player!.id);
    }

    if (viewmodel.emirates == null) {
      viewmodel.getEmirates();
    }
    stateController = TextEditingController(text: widget.player!.area);
    addressController = TextEditingController(text: widget.player!.address);

    // stateController.text = viewmodel.player.status;
    // stateController.text = viewmodel.player.status;
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

    // addressController = TextEditingController(text: viewmodel.player.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: WHITE,
      appBar: customAppBar(
          context: context,
          title: 'lbl_address',
          withTitle: true,
          onBackButton: () {
            context.navigator.pop();
          }) as PreferredSizeWidget?,
      body: MawahebFutureBuilder<List<EmirateModel>>(
          future: viewmodel.emirateFuture,
          onRetry: viewmodel.getEmirates,
          onSuccess: (emirate) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 43, vertical: 30),
                child: Column(
                  children: [
                    mawhaebDropDown(
                      value: widget.player!.emirate,
                      hint: 'lbl_emirate',
                      context: context,
                      onChanged: (value) {
                        currentEmirate = value;
                      },
                      items: viewmodel.emirates!
                          .map((em) => DropdownMenuItem(
                                child: Text(em.name!),
                                value: em,
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 26),
                    MawahebTextField(
                      hintText: 'lbl_state/province/area',
                      hintColor: Colors.grey,
                      validator: (value) {
                        return stateValidator(context: context, value: value ?? '');
                      },
                      // onChanged: (value) {
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
                        return addressValidator(context: context, value: value ?? '');
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
                              text: 'lbl_save',
                              textColor: Colors.black,
                              borderColor: Colors.black,
                              buttonColor: WHITE,
                              progressColor: RED,
                              isLoading: viewmodel.addressLoading,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  // viewmodel.editAddressInfo(
                                  //   emirateModel: currentEmirate ?? viewmodel.player!.emirate,
                                  //   address: addressController.text ?? viewmodel.player!.address,
                                  //   area: stateController.text ?? viewmodel.player!.area,
                                  // );
                                  viewmodel.editAddressInfo(
                                    emirateModel: currentEmirate ?? viewmodel.player!.emirate,
                                    address: addressController.text,
                                    area: stateController.text,
                                  );
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
