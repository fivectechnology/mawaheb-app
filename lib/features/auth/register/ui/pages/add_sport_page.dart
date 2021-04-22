import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/base/utils/validators.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_loader.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

class AddSportPage extends StatefulWidget {
  const AddSportPage({
    Key key,
  }) : super(key: key);

  static MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (context) => const AddSportPage());

  static const String route = '/add_sport';

  @override
  _AddSportPageState createState() => _AddSportPageState();
}

class _AddSportPageState
    extends ProviderMobxState<AddSportPage, AuthViewmodel> {
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

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return viewmodel.sports == null || viewmodel.positions == null
          ? const Center(child: MawahebLoader())
          : Form(
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
                  // uploadSpace(onPress: () {}),
                  const SizedBox(height: 26),
                  Observer(
                    builder: (_) {
                      return MawahebGradientButton(
                        text: context.translate('lbl_next'),
                        isLoading: viewmodel.registerLoading,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            viewmodel.addSportInfo(
                              height: int.parse(_hightController.text),
                              weight: int.parse(_weightController.text),
                              hand: hand,
                              leg: leg,
                              brief: _briefController.text,
                              sport: currentSport,
                              position: position,
                            );
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
    });
  }

  Widget uploadSpace({Function onPress}) {
    return Container(
      height: context.fullHeight * 0.14,
      decoration: DottedDecoration(
          shape: Shape.box,
          dash: const [10, 10],
          borderRadius: BorderRadius.circular(10),
          color: RED),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: onPress,
                child: SvgPicture.asset('assets/icons/ic_upload.svg')),
            Text(
              context.translate('lbl_upload_video'),
              style: textTheme.headline6,
            ),
            Text(
              context.translate('lbl_max_video'),
              style: textTheme.bodyText2.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
