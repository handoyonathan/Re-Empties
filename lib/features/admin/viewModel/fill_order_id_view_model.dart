import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/components/custom_toast_mixin.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/send_empties/model/transaction_model.dart';

class FillOrderIdVM extends BaseNotifier with CustomToastMixin {
  final String adminID;
  final TransactionModel transactionData;
  final int totalPcs;
  final int point;
  final int cardboardWeight;
  final int glassWeight;
  final int plasticWeight;

  final formKey = GlobalKey<FormState>();
  bool showError = true;
  String otp = ''; // The generated OTP code

  FillOrderIdVM(
    super.ref, {
    required this.adminID,
    required this.transactionData,
    required this.totalPcs,
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
  if (otpInput.isEmpty) {
    // OTP kosong
    showError = true;
    otp = '';
  } else if (otpInput.length < 7) {
    // OTP tidak lengkap
    showError = true;
    otp = otpInput; // Simpan OTP saat ini
  } else if (otpInput == transactionData.dropID) {
    // OTP matches
    showError = false; // Reset error
    otp = otpInput; // Simpan OTP yang benar
  } else {
    // OTP does not match
    showError = true;
  }
  notifyListeners(); // Trigger UI update to show error
}

  String? getErrorText() {
  if (showError) {
    if (otp.isEmpty) {
      return 'DropID cannot be empty. Please fill the DropID.';
    } else if (otp.length < 7) {
      return 'DropID is incomplete. Please enter 7 characters.';
    }
    return 'DropID does not match. Please fill the DropID correctly.';
  }
  return null;
}

  void saveTransaction() async {
    try {
      // Validasi form
      onFilled(otp);
      if (showError) return;

      // Data untuk disimpan ke Firestore
      final transactionUpdateData = {
        'earnPoints': point,
        'orderStatus': 'Verify',
        'totalPcs': totalPcs,
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

      final docSnapshot = await FirebaseFirestore.instance
          // .collection('admin')
          // .doc(adminID)
          .collection('transaction')
          .doc(transactionData.transactionId)
          .get();

      final userID = docSnapshot.data()?['userID'];

      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userID);
      final userDocSnapshot = await userDocRef.get();
      int currentRewardPoints = userDocSnapshot['rewardPoint'];
      int totalRewardPoints = userDocSnapshot['totalPoints'];

      // Tambahkan poin baru ke poin yang ada
      final updatedRewardPoints = currentRewardPoints + point;
      final updatedTotalPoints = totalRewardPoints + point;

      // Update dokumen pengguna dengan poin yang sudah ditambahkan
      final userUpdateData = {
        'rewardPoint': updatedRewardPoints,
        'totalPoints': updatedTotalPoints,
      };
      await userDocRef.update(userUpdateData);

      // Navigasi berdasarkan kondisi `isSend`
      // if (!isSend) {
      //   ctx.pushNamed(paths.fillDropID);
      // } else {
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

}
