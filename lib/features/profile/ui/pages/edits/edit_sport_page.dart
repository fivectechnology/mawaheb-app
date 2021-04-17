import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:mawaheb_app/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:provider/provider.dart';

class EditSportPage extends StatefulWidget {
  const EditSportPage({
    Key key,
  }) : super(key: key);

  static MaterialPageRoute pageRoute(ProfileViewmodel profileViewmodel) =>
      MaterialPageRoute(
        builder: (context) => Provider.value(
          value: profileViewmodel,
          child: const EditSportPage(),
        ),
      );

  static const String route = '/edit_sport_page';

  @override
  _EditSportPageState createState() => _EditSportPageState();
}

class _EditSportPageState
    extends ProviderMobxState<EditSportPage, ProfileViewmodel> {
  final TextEditingController _hightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _briefController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SportModel currentSport;
  SportPositionModel position;
  String leg;
  String hand;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _hightController.dispose();
    _weightController.dispose();
    _briefController.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (viewmodel?.positionFuture == null) {
      viewmodel.getPostions();
    }
    if (viewmodel?.sportFuture == null) {
      viewmodel.getSports();
    }
  }

  String hightValidator(String value) {
    if (value.isEmpty) {
      return 'State is empty';
    }
    return null;
  }

  String weightValidator(String value) {
    if (value.isEmpty) {
      return 'State is empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MawahebFutureBuilder(
          onRetry: viewmodel.getSports,
          future: viewmodel.sportFuture,
          onSuccess: (sport) {
            return Form(
              key: _formKey,
              child: ListView(
                children: [
                  mawhaebDropDown(
                    hint: context.translate('lbl_sport_name'),
                    context: context,
                    onChanged: (value) {
                      currentSport = value;
                    },
                    items: viewmodel.sports
                        .map((em) => DropdownMenuItem(
                              child: Text(em.name),
                              value: em,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 26),
                  mawhaebDropDown(
                    hint: context.translate('lbl_position'),
                    context: context,
                    onChanged: (value) {
                      position = value;
                    },
                    items: viewmodel.positions
                        .map((em) => DropdownMenuItem(
                              child: Text(em.name),
                              value: em,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 26),
                  MawahebTextField(
                    hintText: context.translate('lbl_weight'),
                    hintColor: Colors.grey,
                    context: context,
                    validator: weightValidator,
                    textEditingController: _hightController,
                  ),
                  const SizedBox(height: 26),
                  MawahebTextField(
                    hintText: context.translate('lbl_hight'),
                    hintColor: Colors.grey,
                    context: context,
                    validator: hightValidator,
                    textEditingController: _weightController,
                  ),
                  const SizedBox(height: 26),
                  mawhaebDropDown(
                      hint: context.translate('lbl_prefer_hand'),
                      context: context,
                      items: ['RIGHT', 'LEFT', 'BOTH']
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (v) {
                        hand = v;
                      }),
                  const SizedBox(height: 26),
                  mawhaebDropDown(
                      hint: context.translate('lbl_prefer_leg'),
                      context: context,
                      items: ['RIGHT', 'LEFT', 'BOTH']
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (v) {
                        print(v);
                        print(leg);
                        leg = v;
                      }),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: context.fullHeight * 0.03),
                    child: SizedBox(
                      height: context.fullHeight * 0.15,
                      child: TextFormField(
                        controller: _briefController,
                        maxLines: 10,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color: Colors.grey)),
                          hintText: context.translate('msg_brief'),
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  Observer(
                    builder: (_) {
                      return MawahebButton(
                        text: 'lbl_back',
                        textColor: Colors.black,
                        borderColor: Colors.black,
                        buttonColor: WHITE,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                          }
                        },
                        context: context,
                      );
                    },
                  ),
                  const SizedBox(height: 34),
                ],
              ),
            );
          }),
    );
  }
}
