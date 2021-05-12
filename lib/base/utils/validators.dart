import 'package:core_sdk/utils/extensions/build_context.dart';
import 'package:flutter/cupertino.dart';

String? passwordValidator({required String password, BuildContext? context}) {
  if (password.isEmpty) {
    return context!.translate('msg_password_empty');
  } else if (password.length < 6) {
    return context!.translate('msg_short_password');
  }
  return null;
}

String? emailValidator({required String email, BuildContext? context}) {
  const Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r'{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]'
      r'{0,253}[a-zA-Z0-9])?)*$';
  final RegExp regex = RegExp(pattern as String);

  if (!regex.hasMatch(email) || email == null)
    return context!.translate('msg_invalid_mail');
  else
    return null;
}

String? confirmPasswordValidator(
    {required String password,
    BuildContext? context,
    String? confirmPassword}) {
  if (password.isEmpty) {
    return context!.translate('msg_password_empty');
  } else if (password.length < 3) {
    return context!.translate('msg_short_password');
  } else if (password != confirmPassword) {
    return context!.translate('msg_password_match');
  }
  return null;
}

String? nameValidator({required String name, BuildContext? context}) {
  if (name.isEmpty) {
    return context!.translate('msg_name_empty');
  } else if (name.length < 3) {
    return context!.translate('msg_name_short');
  }
  return null;
}

String? phoneValidator({required String phone, BuildContext? context}) {
  const String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  final RegExp regExp = RegExp(pattern);
  if (phone.isEmpty) {
    return context!.translate('msg_phone_empty');
  } else if (!regExp.hasMatch(phone) || phone.length != 10) {
    return context!.translate('msg_phone_valid');
  }
  return null;
}

String? addressValidator({required String value, BuildContext? context}) {
  if (value.isEmpty) {
    return context!.translate('msg_address_empty');
  }
  return null;
}

String? stateValidator({required String value, BuildContext? context}) {
  if (value.isEmpty) {
    return context!.translate('msg_state_empty');
  }
  return null;
}

String? heightValidator({required String value, BuildContext? context}) {
  if (value.isEmpty) {
    return context!.translate('msg_height_empty');
  }
  return null;
}

String? weightValidator({required String value, BuildContext? context}) {
  if (value.isEmpty) {
    return context!.translate('msg_weight_empty');
  }
  return null;
}

String? briefValidator({required String value, BuildContext? context}) {
  if (value.isEmpty) {
    return context!.translate('msg_brief_empty');
  }
  return null;
}

String? dateValidator({required String value, BuildContext? context}) {
  if (value.isEmpty) {
    return context!.translate('msg_dateOfBirth_empty');
  }
  return null;
}
