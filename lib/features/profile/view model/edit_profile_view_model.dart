import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/form_notifier.dart';
import 'package:re_empties/cores/template/form_validator.dart';
import 'package:re_empties/cores/template/text_input_model.dart';
import 'package:re_empties/features/profile/model/profile_model.dart';

class EditProfileVM extends BaseFormNotifier<ProfileModel>
    with FormValidatorMixin {
  EditProfileVM(super.ref);

  @override
  FutureOr<void> init() {
    form = ProfileModel(
      fullName: TextInputModel(
          validator: (value) => getValidation(
                value: value,
                label: 'Full Name',
                validationList: [Validator.nameFormat],
              )),
      email: TextInputModel(
          validator: (value) => getValidation(
                value: value,
                label: 'Email',
                validationList: [
                  Validator.emailFormat,
                ],
              )),
      phoneNumber: TextInputModel(
          validator: (value) => getValidation(
                value: value,
                label: 'Phone Number',
                validationList: [
                  Validator.phoneFormat,
                ],
              )),
    );
  }

  String removePrefix(String phoneNumber) {
    if (phoneNumber.startsWith('+62')) {
      return phoneNumber.substring(3);
    }
    return phoneNumber;
  }

  void initializeForm(
      {required String fullName,
      required String email,
      required String phoneNumber}) {
    form.fullName.text = fullName;
    form.email.text = email;
    form.phoneNumber.text = removePrefix(phoneNumber);
  }

  @override
  late ProfileModel form;

  Future<void> saveProfileData() async {
    if (validate()) {
      try {
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          final newEmail = form.email.text;
          if (newEmail != currentUser.email) {
            await reauthenticateUser();
            await _updateEmail(currentUser, newEmail);
          }

          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
              .update({
            'userName': form.fullName.text,
            'userEmail': newEmail,
            'userPhoneNumber': form.phoneNumber.text,
          });
        }

        ctx.pop();
        notifyListeners();
      } catch (e) {
        print('Error saving profile data: $e');
      }
    }
  }

  Future<void> _updateEmail(User user, String newEmail) async {
  try {
    await user.verifyBeforeUpdateEmail(newEmail);
    print('Verification email sent to $newEmail. Please check and confirm.');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'requires-recent-login') {
      print('User needs to re-authenticate before changing email.');
      // Tambahkan logika untuk meminta user login ulang
    } else {
      print('Error updating email: ${e.message}');
    }
  }
}

Future<void> reauthenticateUser() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: 'Onetry202\$',
      );
      await user.reauthenticateWithCredential(credential);
      print("Re-authentication successful.");
      print(user.email);
    } catch (e) {
      print("Error during re-authentication: $e");
    }
  }
}


}
