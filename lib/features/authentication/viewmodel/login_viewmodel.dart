import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/form_notifier.dart';
import 'package:re_empties/cores/template/form_validator.dart';
import 'package:re_empties/cores/template/text_input_model.dart';
import 'package:re_empties/features/authentication/model/auth_model.dart';

final loginVM = ChangeNotifierProvider.autoDispose(LoginVM.new);

class LoginVM extends BaseFormNotifier<LoginModel> with FormValidatorMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  LoginVM(super.ref);

  void onLogin(BuildContext context) async {
    if (validate()) {
      try {
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: form.email.text, // Ambil email dari model
          password: form.password.text, // Ambil password dari model
        );

        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setBool('isLoggedIn', true);
        await preferences.setString('userId', userCredential.user?.uid ?? '');
        print('User Logged in: ${userCredential.user?.uid}');

        String email = form.email.text;
        // Logic login admin
        if (email.endsWith('@ReEmpties.com')) {
          // check admin terdaftar atau engga
          DocumentSnapshot adminDoc = await _firestore
              .collection('admin')
              .doc(userCredential.user?.uid)
              .get();

          if (adminDoc.exists) {
            print("Admin Logged in : ${userCredential.user?.uid}");
            context.go('/admin');
            return;
          } else {
            print("Admin not found in the database.");
          }
        }

        context.go('/home');
      } on FirebaseAuthException catch (e) {
        // Tangani kesalahan login
        print('Failed with error code: ${e.code}');
        print(e.message);
      }
    }
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    form.email.controller.clear();
    form.password.controller.clear();

    ctx.pushReplacement('/login');
  }

  @override
  FutureOr<void> init() {
    form = LoginModel(
      email: TextInputModel(
          validator: (value) => getValidation(
                value: value,
                label: 'Email',
                validationList: [
                  Validator.emailFormat,
                ],
              )),
      password: TextInputModel(
        validator: (value) => getValidation(
          value: value,
          label: 'Password',
          validationList: [
            Validator.passwordFormat,
          ],
        ),
      ),
    );
  }

  @override
  late LoginModel form;
}
