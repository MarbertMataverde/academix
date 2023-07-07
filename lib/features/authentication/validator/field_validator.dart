import 'package:academix/constants/regex.dart';

/// The `firstNameValidator` function validates the first name field.
///
/// It takes a `value` parameter and checks if it is empty. If it is empty, it returns an error message 'Enter your first name.'; otherwise, it returns `null`, indicating that the value is valid.
String? firstNameValidator(value) {
  if (value!.isEmpty) {
    return 'Enter your first name.';
  }
  return null;
}

/// The `middleNameValidator` function validates the middle name field.
///
/// It takes a `value` parameter and checks if it is empty. If it is empty, it returns an error message 'Enter your middle name.'; otherwise, it returns `null`, indicating that the value is valid.
String? middleNameValidator(value) {
  if (value!.isEmpty) {
    return 'Enter your middle name.';
  }
  return null;
}

/// The `lastNameValidator` function validates the last name field.
///
/// It takes a `value` parameter and checks if it is empty. If it is empty, it returns an error message 'Enter your last name.'; otherwise, it returns `null`, indicating that the value is valid.
String? lastNameValidator(value) {
  if (value!.isEmpty) {
    return 'Enter your last name.';
  }
  return null;
}

/// The `contactNumberValidator` function validates the contact number field.
///
/// It takes a `value` parameter and checks if it is empty. If it is empty, it returns an error message 'Enter your contact number.'.
/// It also checks if the value has exactly 11 digits. If not, it returns an error message 'Please enter an 11-digit number.'.
/// If both conditions pass, it returns `null`, indicating that the value is valid.
String? contactNumberValidator(value) {
  if (value!.isEmpty) {
    return 'Enter your contact number.';
  }
  if (value.toString().length != 11) {
    return 'Please enter an 11-digit number.';
  }
  return null;
}

/// The `fullAddressValidator` function validates the full address field.
///
/// It takes a `value` parameter and checks if it is empty. If it is empty, it returns an error message 'Enter your full address.'.
/// It also checks if the value has a minimum length of 10 characters. If not, it returns an error message 'Minimum 10 characters required for full address.'.
/// If both conditions pass, it returns `null`, indicating that the value is valid.
String? fullAddressValidator(value) {
  if (value!.isEmpty) {
    return 'Enter your full address.';
  }
  if (value.toString().length <= 10) {
    return 'Minimum 10 characters required for full address.';
  }
  return null;
}

/// The `studentNumberValidator` function validates the student number field.
///
/// It takes a `value` parameter and checks if it is empty. If it is empty, it returns an error message 'Enter your student number.'.
/// It also checks if the value has exactly 10 digits. If not, it returns an error message 'Please enter your 10-digit student number.'.
/// If both conditions pass, it returns `null`, indicating that the value is valid.
String? studentNumberValidator(value) {
  if (value!.isEmpty) {
    return 'Enter your student number.';
  }
  if (value.toString().length != 10) {
    return 'Please enter your 10-digit student number.';
  }
  return null;
}

/// The `emailValidator` function validates the email address field.
///
/// It takes a `value` parameter and performs two validations.
/// First, it checks if the value is empty. If it is empty, it returns an error message 'Please enter an email.'.
/// Second, it uses a regular expression pattern to validate the email format. If the value does not match the pattern, it returns an error message 'Please enter a valid email.'.
/// If both validations pass, it returns `null`, indicating that the value is valid.
String? emailValidator(value) {
  if (value!.isEmpty) {
    return 'Please enter an email.';
  }
  if (!RegExp(Regex.email).hasMatch(value)) {
    return 'Please enter a valid email.';
  }
  return null;
}

/// The `passwordValidator` function validates the password field.
///
/// It takes a `value` parameter and performs multiple validations.
/// First, it checks if the value is empty. If it is empty, it returns an error message 'Please enter a password'.
/// Then, it checks if the value has a length less than 8 characters. If it does, it returns an error message 'Password must be at least 8 characters'.
/// Next, it checks if the value contains at least one uppercase letter, lowercase letter, number, and special character using regular expressions. If any of these conditions are not met, it returns the corresponding error message.
/// If all validations pass, it returns `null`, indicating that the value is valid.
String? passwordValidator(value) {
  if (value!.isEmpty) {
    return 'Please enter a password';
  } else if (value.length < 8) {
    return 'Password must be at least 8 characters';
  } else if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain at least one uppercase letter';
  } else if (!value.contains(RegExp(r'[a-z]'))) {
    return 'Password must contain at least one lowercase letter';
  } else if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one number';
  } else if (!value.contains(RegExp(r'[!@#\$%\^&\*]'))) {
    return 'Password must contain at least one special character';
  }
  return null;
}
