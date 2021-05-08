import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mawaheb_app/app/app.dart';
import 'package:mawaheb_app/app/base_page.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/base/utils/validators.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_loader.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_model.dart';
import 'package:mawaheb_app/features/auth/data/models/sport_position_model.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:mawaheb_app/features/profile/viewmodels/edit_sport_viewmodel.dart';
import 'package:mawaheb_app/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:provider/provider.dart';

class EditSportPage extends StatefulWidget {
  const EditSportPage({Key key, this.player}) : super(key: key);

  final PlayerModel player;

  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //
  // static MaterialPageRoute pageRoute(ProfileViewmodel profileViewmodel) =>
  //     MaterialPageRoute(
  //       builder: (context) => Provider.value(
  //         value: profileViewmodel,
  //         child: const EditSportPage(),
  //       ),
  //     );

  // static MaterialPageRoute<dynamic> get pageRoute =>
  //     MaterialPageRoute<dynamic>(builder: (_) => const EditSportPage());

  @override
  _EditSportPageState createState() => _EditSportPageState();
}

class _EditSportPageState extends MobxState<EditSportPage, EditSportViewmodel> {
  TextEditingController hightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController briefController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SportModel currentSport;
  SportPositionModel position;
  String leg;
  String hand;

  @override
  void initState() {
    super.initState();

    if (viewmodel?.player == null) {
      viewmodel.fetchPlayer(id: viewmodel.prefsRepository.player.id);
    }

    if (viewmodel?.positionFuture == null) {
      viewmodel.getPositions(
          sportId: viewmodel.prefsRepository.player.sport.id);
    }
    if (viewmodel?.sportFuture == null) {
      viewmodel.getSports();
    }

    hightController = TextEditingController(text: widget.player.height);
    weightController = TextEditingController(text: widget.player.weight);
    briefController = TextEditingController(text: widget.player.brief);
  }

  @override
  void dispose() {
    hightController.dispose();
    weightController.dispose();
    briefController.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> test = {
      'RIGHT': context.translate('lbl_right'),
      'LEFT': context.translate('lbl_left'),
      'BOTH': context.translate('lbl_both'),
    };

    return Scaffold(
      key: EditSportPage.scaffoldKey,
      backgroundColor: WHITE,
      appBar: customAppBar(
          context: context,
          title: 'lbl_sport',
          withTitle: true,
          onBackButton: () {
            context.navigator.pop();
          }),
      body: Observer(builder: (_) {
        return viewmodel.sportLoading == true ||
                viewmodel.positionsLoading == true
            ? const Center(child: MawahebLoader())
            : Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 43, vertical: 30),
                  child: ListView(
                    children: [
                      mawhaebDropDown(
                        value: currentSport ?? widget.player.sport,
                        hint: context.translate('lbl_sport_name'),
                        context: context,
                        onChanged: (value) {
                          currentSport = value;
                          viewmodel.getPositions(sportId: currentSport.id);
                        },
                        items: viewmodel.sports
                            .map((em) => DropdownMenuItem(
                                  child: Text(em.name),
                                  value: em,
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 26),
                      if (viewmodel.positions != null)
                        mawhaebDropDown(
                          value: currentSport == null
                              ? widget.player.position
                              : null,
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
                      // if (viewmodel.positions == null)
                      //   InkWell(
                      //     onTap: () {
                      //       viewmodel.showSnack(
                      //           context.translate('msg_select_sport'),
                      //           duration: const Duration(seconds: 3),
                      //           scaffoldKey: EditSportPage.scaffoldKey);
                      //     },
                      //     child: mawhaebDropDown(
                      //       hint: context.translate('lbl_position'),
                      //       context: context,
                      //     ),
                      //   ),
                      const SizedBox(height: 26),
                      MawahebTextField(
                        keyboardType: TextInputType.number,
                        hintText: context.translate('lbl_weight'),
                        hintColor: Colors.grey,
                        validator: (value) {
                          return weightValidator(
                              context: context, value: value);
                        },
                        textEditingController: weightController,
                        context: context,
                      ),
                      const SizedBox(height: 26),
                      MawahebTextField(
                        keyboardType: TextInputType.number,
                        hintText: context.translate('lbl_hight'),
                        hintColor: Colors.grey,
                        context: context,
                        validator: (value) {
                          return heightValidator(
                              context: context, value: value);
                        },
                        // onChanged: (value) {
                        //   hightController.text = value;
                        // },
                        textEditingController: hightController,
                      ),
                      const SizedBox(height: 26),
                      mawhaebDropDown(
                          value: widget.player.handEn,
                          hint: context.translate('lbl_prefer_hand'),
                          context: context,
                          items: test
                              .map((key, value) {
                                return MapEntry(
                                    key,
                                    DropdownMenuItem(
                                      value: key,
                                      child: Text(value),
                                    ));
                              })
                              .values
                              .toList(),
                          // ['RIGHT', 'LEFT', 'BOTH']
                          //     .map((e) => DropdownMenuItem(
                          //           child: Text(e),
                          //           value: e,
                          //         ))
                          //     .toList(),
                          onChanged: (v) {
                            hand = v;
                          }),
                      const SizedBox(height: 26),
                      mawhaebDropDown(
                          value: widget.player.legEn,
                          hint: context.translate('lbl_prefer_leg'),
                          context: context,
                          items: test
                              .map((key, value) {
                                return MapEntry(
                                    key,
                                    DropdownMenuItem(
                                      value: key,
                                      child: Text(value),
                                    ));
                              })
                              .values
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
                            controller: briefController,
                            maxLines: 10,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
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
                            text: 'lbl_save',
                            textColor: Colors.black,
                            borderColor: Colors.black,
                            buttonColor: WHITE,
                            isLoading: viewmodel.playerLoading,
                            progressColor: RED,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();

                                viewmodel.editSportInfo(
                                  height: double.parse(hightController.text)
                                          .toInt() ??
                                      viewmodel.player.height,
                                  weight: double.parse(weightController.text)
                                          .toInt() ??
                                      viewmodel.player.weight,
                                  hand: hand ?? viewmodel.player.hand,
                                  leg: leg ?? viewmodel.player.leg,
                                  brief: briefController.text ??
                                      viewmodel.player.brief,
                                  sport: currentSport ?? viewmodel.player.sport,
                                  position:
                                      position ?? viewmodel.player.position,
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
                ),
              );
      }),
    );
  }
}
