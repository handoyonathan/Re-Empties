import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart' hide ChangeNotifierProvider;
import 'package:re_empties/cores/router/router_constant.dart';

import 'package:re_empties/cores/template/form_notifier.dart';
import 'package:re_empties/cores/template/form_validator.dart';
import 'package:re_empties/cores/template/text_input_model.dart';
import 'package:re_empties/features/authentication/model/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final loginVM = ChangeNotifierProvider.autoDispose(LoginVM.new);

class LoginVM extends BaseFormNotifier<LoginModel> with FormValidatorMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginVM(super.ref);

  // LoginModel? user;

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
