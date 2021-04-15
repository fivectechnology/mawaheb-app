import 'package:core_sdk/utils/mobx/mobx_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_drop_down.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_future_builder.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_gradient_button.dart';
import 'package:mawaheb_app/base/widgets/mawaheb_text_field.dart';
import 'package:mawaheb_app/features/auth/data/models/category_model.dart';
import 'package:mawaheb_app/features/auth/data/models/country_model.dart';
import 'package:mawaheb_app/features/auth/viewmodels/auth_viewmodel.dart';
import 'package:core_sdk/utils/extensions/build_context.dart';

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
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  CountryModel currentCountry;
  CategoryModel currentCategory;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    return MawahebFutureBuilder(
        onRetry: viewmodel.getCategories,
        future: viewmodel.countryFuture,
        onSuccess: (country) {
          return ListView(
            children: [
              imageRow(),
              const SizedBox(height: 26),
              MawahebTextField(
                hintText: 'lbl_full_name',
                hintColor: Colors.grey,
                textEditingController: _nameController,
                context: context,
              ),
              const SizedBox(height: 26),
              MawahebTextField(
                  hintText: 'lbl_date_of_birth',
                  hintColor: Colors.grey,
                  textEditingController: _dateOfBirthController,
                  context: context),
              const SizedBox(height: 26),
              MawahebTextField(
                  hintText: 'lbl_phone_num',
                  hintColor: Colors.grey,
                  textEditingController: _phoneController,
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
              MawahebTextField(
                hintText: 'lbl_gender',
                hintColor: Colors.grey,
                textEditingController: _genderController,
                context: context,
              ),
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
                    onPressed: () => viewmodel.addPersonalInfo(
                      phone: _phoneController.text,
                      name: _nameController.text,
                      gender: _genderController.text,
                      dateOfBirth: _dateOfBirthController.text,
                      categoryModel: currentCategory,
                      country: currentCountry,
                    ),
                  );
                },
              ),
              const SizedBox(height: 34),
            ],
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
            onPressed: () {},
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
