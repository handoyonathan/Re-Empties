import 'package:re_empties/cores/template/notifer.dart';

mixin FormValidatorMixin on BaseNotifier {
  final RegExp passwordRegex =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
  final RegExp emailRegex =
      RegExp(r'^[\w-\.]+@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$');
  final RegExp phoneRegex = RegExp(r'^(?:\+62|08)\d{10,12}$');
  final RegExp nameRegex = RegExp(r'^[a-zA-Z]{4,}(?: [a-zA-Z]+){0,2}$');

  String? getValidation({
    required String value,
    required String label,
    required List<Validator> validationList,
    String? confirmValue,
    Function()? setPhoneBorderError,
  }) {
    // Empty validation
    if (value.isEmpty) {
      if (setPhoneBorderError != null) {
        setPhoneBorderError();
      }
      return '$label can not be empty';
    }

    if (validationList.contains(Validator.phoneFormat) &&
        !phoneRegex.hasMatch(value)) {
      return '$label must be number and start with +62 or 08';
    }

    // Email validation
    if (validationList.contains(Validator.emailFormat) &&
        !emailRegex.hasMatch(value)) return 'Email must be a valid email';

    // Password validation
    if (validationList.contains(Validator.passwordFormat) &&
        !passwordRegex.hasMatch(value)) {
      return 'Password must be at least 8 alphanumeric characters';
    }

    // Confirm Password validation
    if (validationList.contains(Validator.confirmPassword) &&
        ((confirmValue ?? '').isEmpty || value != (confirmValue ?? ''))) {
      return 'Password not matches';
    }

    // full name validation
    if (validationList.contains(Validator.nameFormat)) {
      // Check if name length is at least 4 characters
      if (value.length < 4) {
        return '$label must be at least 4 characters';
      }

      // Check if name contains numbers
      if (!nameRegex.hasMatch(value)) {
        return '$label cannot contain numbers';
      }
    }

    return null;
  }
}

enum Validator {
  emailFormat,
  passwordFormat,
  confirmPassword,
  phoneFormat,
  nameFormat,
}
