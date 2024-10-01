import 'package:re_empties/cores/template/notifer.dart';

mixin FormValidatorMixin on BaseNotifier {
  final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
  final RegExp emailRegex =
      RegExp(r'^[\w-\.]+@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$');
  final RegExp phoneRegex = RegExp(r'^\+62\d{9,12}$');
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
      return '$label tidak boleh kosong';
    }

    // Length / 8 Characters validation
    if (validationList.contains(Validator.length) && value.length < 8) {
      return '$label kurang dari 8 karakter';
    }

    if (validationList.contains(Validator.phoneFormat) &&
        !phoneRegex.hasMatch(value)) {
      return '$label hanya boleh berisi angka dan diawali dengan +62';
    }

    // Email validation
    if (validationList.contains(Validator.emailFormat) &&
        !emailRegex.hasMatch(value)) return 'Format email salah';

    // Password validation
    if (validationList.contains(Validator.passwordFormat) &&
        !passwordRegex.hasMatch(value)) {
      return 'Format password salah';
    }

    // Confirm Password validation
    if (validationList.contains(Validator.confirmPassword) &&
        ((confirmValue ?? '').isEmpty || value != (confirmValue ?? ''))) {
      return 'Password yang Anda masukkan tidak sesuai';
    }

    // full name validation
    if (validationList.contains(Validator.nameFormat) &&
        !nameRegex.hasMatch(value)) {
      return 'Nama yang Anda masukkan tidak sesuai';
    }

    return null;
  }
}

enum Validator {
  length,
  emailFormat,
  passwordFormat,
  confirmPassword,
  phoneFormat,
  nameFormat,
}
