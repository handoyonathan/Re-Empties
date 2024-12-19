import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/components/custom_toast_mixin.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/send_empties/model/transaction_model.dart';

class FillOrderIdVM extends BaseNotifier with CustomToastMixin{
  final String adminID;
  final TransactionModel transactionData;
  final int weight;
  final int point;
  final int cardboardWeight;
  final int glassWeight;
  final int plasticWeight;

  final formKey = GlobalKey<FormState>();
  bool showError = false;
  String otp = ''; // The generated OTP code

  FillOrderIdVM(
    super.ref, {
    required this.adminID,
    required this.transactionData,
    required this.weight,
    required this.point,
    required this.cardboardWeight,
    required this.glassWeight,
    required this.plasticWeight,
  });

  @override
  FutureOr<void> init() {
    print(transactionData.transactionId);
  }

  /// Handle OTP submission
  onFilled(String otpInput) {
    if (otpInput == transactionData.dropID) {
      // OTP matches
      // showCustomToast('Success! Transaction verified');
      showError = false; // Reset error
    } else {
      // OTP does not match
      // showCustomToast('DropID does not match', isError: true);
      showError = true;
      notifyListeners(); // Trigger UI update to show error
    }
  }

  String? getErrorText() {
    if (showError) return 'DropID does not match. Please fill the DropID correctly';
    return null;
  }

  void saveTransaction() async {
    try {
      // Validasi form
      if (showError) return;

      // Data untuk disimpan ke Firestore
      final transactionUpdateData = {
        'earnPoints': point,
        'orderStatus': 'Verify',
        'totalWeight': weight,
        'cardboardWeight': cardboardWeight,
        'glassWeight': glassWeight,
        'plasticWeight': plasticWeight,
      };

      // Dapatkan referensi dokumen transaksi
      final transactionDocRef = FirebaseFirestore.instance
          // .collection('admin')
          // .doc(adminID)
          .collection('transaction')
          .doc(transactionData.transactionId);

      // Update dokumen transaksi
      await transactionDocRef.update(transactionUpdateData);

      // Navigasi berdasarkan kondisi `isSend`
      // if (!isSend) {
      //   ctx.pushNamed(paths.fillDropID);
      // } else {
        showCustomToast('Transaction verified successfully');
        ctx.pushNamed(paths.success, extra: <String, dynamic>{
          'isSend': false,
          'isAdmin': true,
          'point': point
        });
      // }
    } catch (e) {
      // Tangani error dan tampilkan notifikasi error
      showCustomToast('Error verify transaction: $e', isError: true);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
