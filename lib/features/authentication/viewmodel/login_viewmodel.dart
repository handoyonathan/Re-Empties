import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:re_empties/cores/template/form_notifier.dart';
import 'package:re_empties/cores/template/form_validator.dart';
import 'package:re_empties/cores/template/text_input_model.dart';
import 'package:re_empties/features/authentication/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginVM = ChangeNotifierProvider.autoDispose(LoginVM.new);

class LoginVM extends BaseFormNotifier<LoginModel> with FormValidatorMixin {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginVM(super.ref);

  // LoginModel? user;

  void onLogin() async {
   if (validate()) {
      try {
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: form.email.text, // Ambil email dari model
          password: form.password.text, // Ambil password dari model
        );
        print('User Logged in: ${userCredential.user?.uid}');
      } on FirebaseAuthException catch (e) {
        // Tangani kesalahan login
        print('Failed with error code: ${e.code}');
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
