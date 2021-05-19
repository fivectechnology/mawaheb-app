import 'dart:io';
import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mawaheb_app/app/theme/colors.dart';
import 'package:mawaheb_app/base/utils/validators.dart';
import 'package:mawaheb_app/base/widgets/custom_app_bar.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_loader.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/base/widgets/uploading_video_loader.dart';
import 'package:mawaheb_app/features/auth/data/models/category_model.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/data/models/player_model.dart';
import 'package:mawaheb_app/features/profile/viewmodels/edit_personal_viewmodel.dart';

import 'package:intl/intl.dart';

class EditPersonalPage extends StatefulWidget {
  const EditPersonalPage({Key? key, this.player}) : super(key: key);

  final PlayerModel? player;

  // static MaterialPageRoute pageRoute(ProfileViewmodel profileViewmodel) =>
  //     MaterialPageRoute(
  //       builder: (context) => Provider.value(
  //         value: profileViewmodel,
  //         child: const EditPersonalPage(),
  //       ),
  //     );

  static const String route = '/edit_player_info';
  static final GlobalKey<State> keyLoader = GlobalKey<State>();

  @override
  _EditPersonalPageState createState() => _EditPersonalPageState();
}

class _EditPersonalPageState extends MobxState<EditPersonalPage, EditPersonalViewmodel> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dateOfBirth = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool dirty = false;

  CountryModel? currentCountry;
  CategoryModel? currentCategory;
  String? gender;
  String? dateOfBirth;
  DateTime? _selectedDate;

  String? fileType;
  String? fileName;
  int? fileSize;

  final picker = ImagePicker();

  void markAsDirty() => dirty = true;

  @override
  void initState() {
    super.initState();

    if (viewmodel.player == null) {
      viewmodel.fetchPlayer(id: viewmodel.prefsRepository.player!.id);
    }

    if (viewmodel.categories == null) {
      viewmodel.getCategories();
    }

    if (viewmodel.countries == null) {
      viewmodel.getCountries();
    }

    _nameController = TextEditingController(text: widget.player!.name);
    _phoneController = TextEditingController(text: widget.player!.phone);
    _dateOfBirth = TextEditingController(text: widget.player!.dateOfBirth);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _dateOfBirth.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('my debug didChangeDependencies1');

    // if (viewmodel.categoryFuture == null) {
    //   viewmodel.getCategories();
    // }
    // if (viewmodel.countryFuture == null) {
    //   viewmodel.getCountries();
    // }
    if (viewmodel.image != null) {
      viewmodel.imageFile;
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      viewmodel.image = File(pickedFile.path);
      fileName = viewmodel.image!.path.split('/').last;
      fileType = 'image/' + fileName!.split('.').last;
      fileSize = await viewmodel.image!.length();
    } else {
      print('No image selected.');
    }
  }

  _selectDate(BuildContext context) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      dateOfBirth = formatter.format(_selectedDate!);
      _dateOfBirth.text = dateOfBirth!;
    }
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
            context.navigator.pop();
          }) as PreferredSizeWidget?,
      body: Observer(builder: (_) {
        return viewmodel.countries == null || viewmodel.categories == null
            ? const Center(child: MawahebLoader())
            : Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 43, vertical: 30),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      imageRow(),
                      const SizedBox(height: 26),
                      MawahebTextField(
                        hintText: 'lbl_full_name',
                        hintColor: Colors.grey,
                        textEditingController: _nameController,
                        context: context,
                        validator: (value) {
                          markAsDirty();
                          return nameValidator(context: context, name: value ?? '');
                        },
                      ),
                      const SizedBox(height: 26),
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: MawahebTextField(
                            hintText: 'lbl_date_of_birth',
                            hintColor: Colors.grey,
                            textEditingController: _dateOfBirth,
                            context: context,
                            validator: (value) {
                              return dateValidator(context: context, value: value ?? '');
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 26),
                      MawahebTextField(
                        keyboardType: TextInputType.phone,
                        hintText: 'lbl_phone_num',
                        hintColor: Colors.grey,
                        textEditingController: _phoneController,
                        validator: (value) {
                          markAsDirty();
                          return phoneValidator(context: context, phone: value ?? '');
                        },
                        context: context,
                      ),
                      const SizedBox(height: 26),
                      mawhaebDropDown(
                        value: widget.player!.country,
                        hint: 'lbl_nationality',
                        context: context,
                        onChanged: (value) {
                          currentCountry = value;
                        },
                        items: viewmodel.countries!
                            .map((em) => DropdownMenuItem(
                                  child: Text(em.name!),
                                  value: em,
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 26),
                      mawhaebDropDown(
                        value: widget.player!.category,
                        hint: 'lbl_category',
                        context: context,
                        onChanged: (value) {
                          markAsDirty();
                          currentCategory = value;
                        },
                        items: viewmodel.categories!
                            .map((em) => DropdownMenuItem(
                                  child: Text(em.title!),
                                  value: em,
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 26),
                      AbsorbPointer(
                        child: mawhaebDropDown(
                          value: context.translate('lbl_male'),
                          hint: 'lbl_gender',
                          context: context,
                          onChanged: (value) {
                            markAsDirty();
                            gender = value;
                          },
                          items: [context.translate('lbl_male')]
                              .map((em) => DropdownMenuItem(
                                    child: Text(em),
                                    value: em,
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 26),
                      Observer(
                        builder: (_) {
                          return MawahebButton(
                              context: context,
                              text: 'lbl_save',
                              textColor: Colors.black,
                              borderColor: Colors.black,
                              buttonColor: WHITE,
                              progressColor: RED,
                              isLoading: viewmodel.personalLoading,
                              onPressed: () async {
                                if (viewmodel.image != null) {
                                  viewmodel.uploadImage(
                                    playerId: viewmodel.player!.id,
                                    playerVersion: viewmodel.player!.version,
                                    file: viewmodel.image,
                                    fileType: fileType,
                                    fileName: fileName,
                                    fileSize: fileSize,
                                  );

                                  viewmodel.editPersonalInfo(
                                    phone:
                                        _phoneController.text != '' ? _phoneController.text : viewmodel.player!.phone,
                                    name: _nameController.text != '' ? _nameController.text : viewmodel.player!.name,
                                    gender: 'MALE',
                                    dateOfBirth: dateOfBirth ?? viewmodel.player!.dateOfBirth,
                                    categoryModel: currentCategory ?? viewmodel.player!.category,
                                    country: currentCountry ?? viewmodel.player!.country,
                                  );
                                  uploadingVideoLoader(
                                      context: context, key: EditPersonalPage.keyLoader, text: 'msg_uploading_image');
                                } else {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    // viewmodel.editPersonalInfo(
                                    //   phone: _phoneController.text ?? viewmodel.player!.phone,
                                    //   name: _nameController.text ?? viewmodel.player as String?,
                                    //   gender: 'MALE',
                                    //   dateOfBirth: dateOfBirth ?? viewmodel.player!.dateOfBirth,
                                    //   categoryModel: currentCategory ?? viewmodel.player!.category,
                                    //   country: currentCountry ?? viewmodel.player!.country,
                                    // );
                                    viewmodel.editPersonalInfo(
                                      phone: _phoneController.text,
                                      name: _nameController.text,
                                      gender: 'MALE',
                                      dateOfBirth: dateOfBirth ?? viewmodel.player!.dateOfBirth,
                                      categoryModel: currentCategory ?? viewmodel.player!.category,
                                      country: currentCountry ?? viewmodel.player!.country,
                                    );
                                  }
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
    return InkWell(
      onTap: () async {
        await getImage();
      },
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: context.fullWidth * 0.03),
            height: context.fullHeight * 0.12,
            width: context.fullHeight * 0.12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 2.0),
            ),
            child: viewmodel.imageFile == null
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
                    backgroundImage: FileImage(viewmodel.imageFile!),
                    radius: 200.0,
                  ),
          ),
          Text(
            context.translate('lbl_add_image'),
            style: textTheme!.bodyText1!.copyWith(color: Colors.grey, fontSize: 12),
          )
        ],
      ),
    );
  }
}
