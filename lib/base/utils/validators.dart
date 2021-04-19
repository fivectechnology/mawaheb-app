String passwordValidator(String password) {
  if (password.isEmpty) {
    return 'Password empty';
  } else if (password.length < 3) {
    return 'Password is too short';
  }
  return null;
}

String emailValidator(String email) {
  const Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r'{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]'
      r'{0,253}[a-zA-Z0-9])?)*$';
  final RegExp regex = RegExp(pattern);

  if (!regex.hasMatch(email) || email == null)
    return 'Enter a valid email address';
  else
    return null;
}

String nameValidator(String name) {
  if (name.isEmpty) {
    return 'Name is empty';
  } else if (name.length < 3) {
    return 'name is too short';
  }
  return null;
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

String stateValidator(String value) {
  if (value.isEmpty) {
    return 'State is empty';
  }
  return null;
}

String addressValidator(String value) {
  if (value.isEmpty) {
    return 'Address is empty';
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

String dateValidator(String date) {
  if (date.isEmpty) {
    return 'date is empty';
  }
  return null;
}
