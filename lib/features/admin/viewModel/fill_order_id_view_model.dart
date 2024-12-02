import 'dart:async';
import 'package:flutter/material.dart';
import 'package:re_empties/cores/template/notifer.dart';

class FillOrderIdVM extends BaseNotifier {
  final formKey = GlobalKey<FormState>();
  bool showError = false;
  String otp = ''; // The generated OTP code

  FillOrderIdVM(super.ref,);


  @override
  FutureOr<void> init() {
  }

  /// Handle OTP submission
  onFilled(String otpInput) {
    // showError = false;

    // // Simulate success
    // otp = otpInput;
    // print("OTP Verified: $otpInput");
    // showError = false;
    // notifyListeners();
  }

  String? getErrorText() {
    if (showError) return ' Kode yang Anda masukkan salah';
    return null;
  }


  @override
  void dispose() {
    super.dispose();
  }
}
