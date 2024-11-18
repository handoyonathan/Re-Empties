import 'package:re_empties/cores/template/text_input_model.dart';

class ProfileModel {
  final TextInputModel fullName;
  final TextInputModel email;
  final TextInputModel phoneNumber;

  ProfileModel(
      {required this.fullName, required this.email, required this.phoneNumber});
}
