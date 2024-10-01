import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:re_empties/cores/template/form_notifier.dart';
import 'package:re_empties/cores/template/form_validator.dart';
import 'package:re_empties/cores/template/text_input_model.dart';
import 'package:re_empties/features/authentication/model/auth_model.dart';
import 'package:flutter_riverpod/src/change_notifier_provider.dart';

final registerVM = ChangeNotifierProvider.autoDispose(RegisterVM.new);

class RegisterVM extends BaseFormNotifier<RegisterModel>
    with FormValidatorMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RegisterVM(super.ref);

  void onRegister() async {
    if (validate()) {
      try {
        //  bikin new user di firebase auth
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: form.email.text,
          password: form.password.text,
        );
        print('User Logged in: ${userCredential.user?.uid}');

        // add user data to firestore
        RegisterModel user = RegisterModel(
          fullName: form.fullName,
          email: form.email,
          phoneNumber: form.phoneNumber,
          password: form.password,
          confirmPassword: form.confirmPassword,
        );
        await _firestore
            .collection('users')
            .doc(userCredential.user?.uid)
            .set(user.toMap());
        print('User data added to Firestore');
      } on FirebaseAuthException catch (e) {
        // Tangani kesalahan login
        print('Failed with error code: ${e.code}');
        print(e.message);
      }
    }
  }

  // Future<void> registerUser({
  //   required String fullName,
  //   required String email,
  //   required String phoneNumber,
  //   required String password,
  // }) async {
  //   try {
  //     // bikin new user di firebase auth
  //     UserCredential userCredential = await _auth
  //         .createUserWithEmailAndPassword(email: email, password: password);

  //     // add user data to firestore
  //     RegisterModel user = RegisterModel(
  //       fullName: fullName,
  //       email: email,
  //       phoneNumber: phoneNumber,
  //     );
  //     await _firestore
  //         .collection('users')
  //         .doc(userCredential.user?.uid)
  //         .set(user.toMap());
  //   } catch (e) {
  //     print("Error in registration: $e");
  //   }
  // }

  @override
  late RegisterModel form;

  @override
  FutureOr<void> init() {
    form = RegisterModel(
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
      password: TextInputModel(
          validator: (value) => getValidation(
                value: value,
                label: 'Password',
                validationList: [
                  Validator.passwordFormat,
                ],
              )),
      confirmPassword: TextInputModel(
          validator: (value) => getValidation(
                value: value,
                label: 'Confirm Password',
                validationList: [
                  Validator.confirmPassword,
                ],
                confirmValue: form.password.text,
              )),
    );
  }
}
