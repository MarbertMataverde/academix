import 'package:academix/constants/regex.dart';

/// The following functions are used for validating form fields. Each function takes a `value` parameter and performs specific validations on it. If the value passes the validation, the function returns `null`, indicating that the value is valid. Otherwise, it returns an error message describing the validation failure.

/// firstNameValidator: Validates the first name field.
///   - Checks if the value is empty. Returns an error message if it is.
///   - Returns `null` if the value is valid.
String? firstNameValidator(value) {
  if (value!.isEmpty) {
    return 'Enter your first name.';
  }
  return null;
}

/// middleNameValidator: Validates the middle name field.
///   - Checks if the value is empty. Returns an error message if it is.
///   - Returns `null` if the value is valid.
String? middleNameValidator(value) {
  if (value!.isEmpty) {
    return 'Enter your middle name.';
  }
  return null;
}

/// lastNameValidator: Validates the last name field.
///   - Checks if the value is empty. Returns an error message if it is.
///   - Returns `null` if the value is valid.
String? lastNameValidator(value) {
  if (value!.isEmpty) {
    return 'Enter your last name.';
  }
  return null;
}

/// contactNumberValidator: Validates the contact number field.
///   - Checks if the value is empty. Returns an error message if it is.
///   - Checks if the value has exactly 11 digits. Returns an error message if it does not.
///   - Returns `null` if the value is valid.
String? contactNumberValidator(value) {
  if (value!.isEmpty) {
    return 'Enter your contact number.';
  }
  if (value.toString().length != 11) {
    return 'Please enter an 11-digit number.';
  }
  return null;
}

/// fullAddressValidator: Validates the full address field.
///   - Checks if the value is empty. Returns an error message if it is.
///   - Checks if the value has a minimum length of 10 characters. Returns an error message if it does not.
///   - Returns `null` if the value is valid.
String? fullAddressValidator(value) {
  if (value!.isEmpty) {
    return 'Enter your full address.';
  }
  if (value.toString().length <= 10) {
    return 'Minimum 10 characters required for full address.';
  }
  return null;
}

/// studentNumberValidator: Validates the student number field.
///   - Checks if the value is empty. Returns an error message if it is.
///   - Checks if the value has exactly 10 digits. Returns an error message if it does not.
///   - Returns `null` if the value is valid.
String? studentNumberValidator(value) {
  if (value!.isEmpty) {
    return 'Enter your student number.';
  }
  if (value.toString().length != 10) {
    return 'Please enter your 10-digit student number.';
  }
  return null;
}

/// emailValidator: Validates the email address field.
///   - Checks if the value is empty. Returns an error message if it is.
///   - Uses a regular expression pattern to validate the email format. Returns an error message if the value does not match the pattern.
///   - Returns `null` if the value is valid.
String? emailValidator(value) {
  if (value!.isEmpty) {
    return 'Please enter an email.';
  }
  if (!RegExp(Regex.email).hasMatch(value)) {
    return 'Please enter a valid email.';
  }
  return null;
}

/// passwordValidator: Validates the password field.
///   - Checks if the value is empty. Returns an error message if it is.
///   - Checks if the value has a length less than 8 characters. Returns an error message if it does.
///   - Checks if the value contains at least one uppercase letter, lowercase letter, number, and special character using regular expressions. Returns the corresponding error message if any of these conditions are not met.
///   - Returns `null` if the value is valid.
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

/// signInPasswordValidator: Validates the password field for sign-in.
///   - Checks if the value is empty. Returns an error message if it is.
///   - Returns `null` if the value is valid.
String? signInPasswordValidator(value) {
  if (value!.isEmpty) {
    return 'Please enter your password.';
  }
  return null;
}
