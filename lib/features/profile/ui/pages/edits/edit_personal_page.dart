import 'dart:io';

import 'package:core_sdk/utils/colors.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/data/models/category_model.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:provider/provider.dart';

class EditPersonalPage extends StatefulWidget {
  const EditPersonalPage({
    Key key,
  }) : super(key: key);

  static MaterialPageRoute pageRoute(ProfileViewmodel profileViewmodel) =>
      MaterialPageRoute(
        builder: (context) => Provider.value(
          value: profileViewmodel,
          child: const EditPersonalPage(),
        ),
      );

  static const String route = '/edit_player_info';

  @override
  _EditPersonalPageState createState() => _EditPersonalPageState();
}

class _EditPersonalPageState
    extends ProviderMobxState<EditPersonalPage, ProfileViewmodel> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  CountryModel currentCountry;
  CategoryModel currentCategory;
  String gender;
  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _dateOfBirthController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _nameController = TextEditingController(text: viewmodel.player.name);
    _dateOfBirthController =
        TextEditingController(text: viewmodel.player.dateOfBirth);
    _phoneController = TextEditingController(text: viewmodel.player.phone);

    if (viewmodel?.categoryFuture == null) {
      viewmodel.getCategories();
    }
    if (viewmodel?.countryFuture == null) {
      viewmodel.getCountries();
    }
  }

  String nameValidator(String name) {
    if (name.isEmpty) {
      return 'FullName is empty';
    } else if (name.length < 3) {
      return 'FullName must be more than 2 character';
    }
    return null;
  }

  String dateValidator(String date) {
    if (date.isEmpty) {
      return 'date is empty';
    }
    return null;
  }

  String phoneValidator(String phone) {
    const String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    final RegExp regExp = RegExp(pattern);
    if (phone.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(phone)) {
      return 'Please enter valid mobile number (10 digits)';
    }
    return null;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      appBar: customAppBar(
          context: context, title: 'lbl_personal_info', withTitle: true),
      body: MawahebFutureBuilder(
          onRetry: viewmodel.getCategories,
          future: viewmodel.countryFuture,
          onSuccess: (country) {
            return Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 43, vertical: 30),
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
                    MawahebTextField(
                        hintText: 'lbl_date_of_birth',
                        hintColor: Colors.grey,
                        textEditingController: _dateOfBirthController,
                        validator: dateValidator,
                        context: context),
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
                    const SizedBox(height: 26),
                    Observer(
                      builder: (_) {
                        return MawahebButton(
                            context: context,
                            text: 'lbl_back',
                            textColor: Colors.black,
                            borderColor: Colors.black,
                            buttonColor: WHITE,
                            isLoading: viewmodel.playerLoading,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                viewmodel.editPersonalInfo(
                                  phone: _phoneController.text,
                                  name: _nameController.text,
                                  gender: gender,
                                  dateOfBirth: _dateOfBirthController.text,
                                  categoryModel: currentCategory,
                                  country: currentCountry,
                                );
                                context.navigator.pop();
                              }
                            });
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
