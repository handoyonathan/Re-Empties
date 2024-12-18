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

  void initializeForm(
      {required String fullName,
      required String email,
      required String phoneNumber}) {
    form.fullName.text = fullName;
    form.email.text = email;
    form.phoneNumber.text = phoneNumber;
  }

  @override
  late ProfileModel form;

  Future<void> saveProfileData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .update({
          'userName': form.fullName.text,
          'userEmail': form.email.text,
          'userPhoneNumber': form.phoneNumber.text,
        });
      }
      print("INI TOMBOL SAVEEEEEEEEEEE");
      ctx.pop();
      notifyListeners();
    } catch (e) {
      print('Error saving profile data: $e');
    }
  }

  // void goBack(BuildContext context) {
  //   context.pop(); // This will pop the current screen off the navigation stack
  // }
}
