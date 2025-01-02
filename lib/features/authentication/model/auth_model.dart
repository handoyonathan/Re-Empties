import 'package:re_empties/cores/template/text_input_model.dart';

class LoginModel {
  final TextInputModel email;
  final TextInputModel password;

  LoginModel({required this.email, required this.password});
}

class RegisterModel {
  final TextInputModel fullName;
  final TextInputModel email;
  final TextInputModel phoneNumber;
  final TextInputModel password;
  final TextInputModel confirmPassword;

  RegisterModel(
      {required this.fullName,
      required this.email,
      required this.phoneNumber,
      required this.password,
      required this.confirmPassword});

  Map<String, dynamic> toMap() {
    return {
      'userName': fullName.text,
      'userEmail': email.text,
      'userPhoneNumber': '+62${phoneNumber.text}',
      'rewardPoint': 0,
      'totalPoints': 0,
    };
  }
}
