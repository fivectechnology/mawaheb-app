import 'dart:io';

import 'package:core_sdk/utils/colors.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawaheb_app/base/utils/validators.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/data/models/category_model.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:intl/intl.dart';

class PlayerInfoPage extends StatefulWidget {
  const PlayerInfoPage({
    Key key,
  }) : super(key: key);

  static MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (context) => const PlayerInfoPage());

  static const String route = '/player_info';

  @override
  _PlayerInfoPageState createState() => _PlayerInfoPageState();
}

class _PlayerInfoPageState
    extends ProviderMobxState<PlayerInfoPage, AuthViewmodel> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  CountryModel currentCountry;
  CategoryModel currentCategory;
  String gender;
  File _image;
  final picker = ImagePicker();
  DateTime _selectedDate;
  String dateOfBirth;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (viewmodel?.categoryFuture == null) {
      viewmodel.getCategories();
    }
    if (viewmodel?.countryFuture == null) {
      viewmodel.getCountries();
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // ignore: always_declare_return_types
  _selectDate(BuildContext context) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        dateOfBirth = formatter.format(_selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    return MawahebFutureBuilder(
        onRetry: viewmodel.getCategories,
        future: viewmodel.countryFuture,
        onSuccess: (country) {
          return Form(
            key: _formKey,
            child: ListView(
              children: [
                imageRow(),
                const SizedBox(height: 26),
                MawahebTextField(
                  hintText: 'lbl_full_name',
                  hintColor: Colors.grey,
                  textEditingController: _nameController,
                  context: context,
                  validator: nameValidator,
                ),
                const SizedBox(height: 26),
                Row(
                  children: [
                    RaisedButton(
                      color: Colors.white,
                      onPressed: () => _selectDate(context),
                      child: Text('Select Date of Birth',
                          style:
                              textTheme.bodyText1.copyWith(color: TEXT_COLOR)),
                    ),
                    if (dateOfBirth != null)
                      Text('  ' + dateOfBirth,
                          style:
                              textTheme.bodyText1.copyWith(color: TEXT_COLOR))
                  ],
                ),

                // MawahebTextField(
                //     hintText: 'lbl_date_of_birth',
                //     hintColor: Colors.grey,
                //     textEditingController: _dateOfBirthController,
                //     validator: dateValidator,
                //     context: context),
                const SizedBox(height: 26),
                MawahebTextField(
                    hintText: 'lbl_phone_num',
                    hintColor: Colors.grey,
                    textEditingController: _phoneController,
                    validator: phoneValidator,
                    context: context),
                const SizedBox(height: 26),
                mawhaebDropDown(
                  hint: 'lbl_nationality',
                  context: context,
                  onChanged: (value) {
                    currentCountry = value;
                  },
                  items: viewmodel.countries
                      .map((em) => DropdownMenuItem(
                            child: Text(em.name),
                            value: em,
                          ))
                      .toList(),
                ),
                const SizedBox(height: 26),
                mawhaebDropDown(
                  hint: 'lbl_category',
                  context: context,
                  onChanged: (value) {
                    currentCategory = value;
                  },
                  items: viewmodel.categories
                      .map((em) => DropdownMenuItem(
                            child: Text(em.title),
                            value: em,
                          ))
                      .toList(),
                ),
                const SizedBox(height: 26),
                mawhaebDropDown(
                  hint: 'lbl_gender',
                  context: context,
                  onChanged: (value) {
                    gender = value;
                  },
                  items: ['MALE']
                      .map((em) => DropdownMenuItem(
                            child: Text(em),
                            value: em,
                          ))
                      .toList(),
                ),
                // MawahebTextField(
                //   hintText: 'lbl_gender',
                //   hintColor: Colors.grey,
                //   textEditingController: _genderController,
                //   context: context,
                // ),
                const SizedBox(height: 26),
                Observer(
                  builder: (_) {
                    return MawahebGradientButton(
                        context: context,
                        text: 'lbl_next',
                        isLoading: viewmodel.registerLoading,
                        // onPressed: () {
                        //   viewmodel.changeRegisterSlider(PageSliderForawardModel());
                        // },
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();

                            viewmodel.addPersonalInfo(
                              phone: _phoneController.text,
                              name: _nameController.text,
                              gender: gender,
                              dateOfBirth: dateOfBirth,
                              categoryModel: currentCategory,
                              country: currentCountry,
                            );
                          }
                        });
                  },
                ),
                const SizedBox(height: 34),
              ],
            ),
          );
        });
  }

  Widget imageRow() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: context.fullWidth * 0.03),
          height: context.fullHeight * 0.12,
          width: context.fullHeight * 0.12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 2.0),
          ),
          child: IconButton(
            onPressed: getImage,
            icon: const Icon(
              Icons.camera_alt,
              color: Colors.grey,
            ),
          ),
        ),
        Text(
          context.translate('lbl_add_image'),
          style: textTheme.bodyText1.copyWith(color: Colors.grey, fontSize: 12),
        )
      ],
    );
  }
}
