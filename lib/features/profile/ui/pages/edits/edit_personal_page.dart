import 'dart:convert';
import 'dart:io';

import 'package:core_sdk/utils/colors.dart';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawaheb_app/base/utils/validators.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_loader.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/data/models/category_model.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/profile/viewmodels/profile_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  CountryModel currentCountry;
  CategoryModel currentCategory;
  String gender;
  String dateOfBirth;
  DateTime _selectedDate;

  File _image;
  String fileType;
  String fileName;
  int fileSize;

  final picker = ImagePicker();

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
    print('my debug didChangeDependencies1');

    if (viewmodel?.categoryFuture == null) {
      viewmodel.getCategories();
    }
    if (viewmodel?.countryFuture == null) {
      viewmodel.getCountries();
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      fileName = _image.path.split('/').last;
      fileType = fileName.split('.').last;
      fileSize = await _image.length();
    } else {
      print('No image selected.');
    }
  }

  Future<String> imgToBase64(File image) async {
    final bytes = image.readAsBytesSync();
    final base64Str = base64Encode(bytes);

    return base64Str;
  }

  _selectDate(BuildContext context) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      dateOfBirth = formatter.format(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      appBar: customAppBar(
          context: context, title: 'lbl_personal_info', withTitle: true),
      body: Observer(builder: (_) {
        return viewmodel.countries == null || viewmodel.categories == null
            ? const Center(child: MawahebLoader())
            : Form(
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
                        // onChanged: (value) {
                        //   _nameController.text = value;
                        // },
                        validator: nameValidator,
                      ),
                      const SizedBox(height: 26),
                      Row(
                        children: [
                          RaisedButton(
                            color: Colors.white,
                            onPressed: () => _selectDate(context),
                            child: Text(context.translate('lbl_select_birth'),
                                style: textTheme.bodyText1
                                    .copyWith(color: TEXT_COLOR)),
                          ),
                          if (viewmodel.player.dateOfBirth != null)
                            Text('  ' + viewmodel.player.dateOfBirth,
                                style: textTheme.bodyText1
                                    .copyWith(color: TEXT_COLOR))
                        ],
                      ),
                      // MawahebTextField(
                      //     focusNode: dateFocusNode,
                      //     onTab: () {
                      //       _selectDate(context);
                      //     },
                      //     hintText: 'lbl_date_of_birth',
                      //     hintColor: Colors.grey,
                      //     textEditingController: _dateOfBirthController,
                      //     validator: dateValidator,
                      //     onChanged: (value) {
                      //       _dateOfBirthController = value;
                      //     },
                      //     context: context),
                      const SizedBox(height: 26),
                      MawahebTextField(
                          hintText: 'lbl_phone_num',
                          hintColor: Colors.grey,
                          textEditingController: _phoneController,
                          validator: phoneValidator,
                          // onChanged: (value) {
                          //   _phoneController.text = value;
                          // },
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
                              onPressed: () async {
                                // viewmodel.uploadFile(
                                //     file: _image,
                                //     fileName: fileName,
                                //     fileSize: fileSize,
                                //     fileType: fileType);

                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  viewmodel.editPersonalInfo(
                                    phone: _phoneController.text ??
                                        viewmodel.player.phone,
                                    name: _nameController.text ??
                                        viewmodel.player,
                                    gender: gender ?? viewmodel.player.gender,
                                    dateOfBirth: dateOfBirth ??
                                        viewmodel.player.dateOfBirth,
                                    categoryModel: currentCategory ??
                                        viewmodel.player.category,
                                    country: currentCountry ??
                                        viewmodel.player.country,
                                  );
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
          margin: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.03),
          height: context.fullHeight * 0.12,
          width: context.fullHeight * 0.12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 2.0),
          ),
          child: _image == null
              ? IconButton(
                  onPressed: () async {
                    await getImage();
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.grey,
                  ),
                )
              : CircleAvatar(
                  backgroundImage: FileImage(_image),
                  radius: 200.0,
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
