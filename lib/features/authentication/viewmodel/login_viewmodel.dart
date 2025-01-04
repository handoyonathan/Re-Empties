import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/components/custom_toast_mixin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/form_notifier.dart';
import 'package:re_empties/cores/template/form_validator.dart';
import 'package:re_empties/cores/template/text_input_model.dart';
import 'package:re_empties/features/authentication/model/auth_model.dart';

final loginVM = ChangeNotifierProvider.autoDispose(LoginVM.new);

class LoginVM extends BaseFormNotifier<LoginModel> with FormValidatorMixin, CustomToastMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  LoginVM(super.ref);

  void gotoRegister(){
    ctx.goNamed(paths.register);
  }

  void onLogin(BuildContext context) async {
    if (validate()) {
      try {
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: form.email.text, // Ambil email dari model
          password: form.password.text, // Ambil password dari model
        );

        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString('userId', userCredential.user?.uid ?? '');
        // print('User Logged in: ${userCredential.user?.uid}');

        String email = form.email.text;
        // Logic login admin
        if (email.toLowerCase().endsWith('@ReEmpties.com'.toLowerCase())) {
          // check admin terdaftar atau engga
          DocumentSnapshot adminDoc = await _firestore
              .collection('admin')
              .doc(userCredential.user?.uid)
              .get();

          if (adminDoc.exists) {
            print("Admin Logged in : ${userCredential.user?.uid}");
            await preferences.setBool('isAdminLoggedIn', true);
            ctx.goNamed(paths.adminView);
            return;
          } else {
            print("Admin not found in the database.");
          }
        } else {
          DocumentSnapshot userDoc = await _firestore
              .collection('users')
              .doc(userCredential.user?.uid)
              .get();

          if (userDoc.exists) {
            print("User Logged in : ${userCredential.user?.uid}");
            await preferences.setBool('isUserLoggedIn', true);
            ctx.goNamed(paths.home);
            return;
          } else {
            print("User not found in the database.");
          }
        }

        // ctx.goNamed(paths.home);
        // await preferences.setBool('isUserLoggedIn', true);
      } on FirebaseAuthException catch (e) {
        // Tangani kesalahan login
        print('Failed with error code: ${e.code}');
        showCustomToast('Email or Password is invalid', isError:  true);
        print(e.message);
      }
    }
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
