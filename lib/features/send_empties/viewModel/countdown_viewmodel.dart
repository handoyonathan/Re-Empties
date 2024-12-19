import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/components/alert_dialog.dart';
import 'package:re_empties/cores/components/custom_toast_mixin.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';

class CountdownViewModel extends BaseNotifier with CustomToastMixin {
  late Timer _timer;
  int _countdown = 10;
  final String transactionId;
  final int point;

  int get countdown => _countdown;

  CountdownViewModel(super.ref, {required this.transactionId, required this.point}) {
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown == 1) {
        timer.cancel();
        ctx.goNamed(paths.success, extra: <String, dynamic>{
          'isSend': true,
          'point': point,
        });
      } else {
        _countdown--;
        notifyListeners();
      }
    });
  }

  void cancelCountdown() {
    _timer.cancel();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          onConfirm: () {
            Navigator.of(context).pop(); // Tutup dialog
            deleteTransaction(context);
            print('masuk confirm');
          },
          onCancel: () {
            Navigator.of(context).pop(); // Tutup dialog
            print('masuk cancel');
          },
        );
      },
    );
  }

  void deleteTransaction(BuildContext context) async {
    try {
      // Referensi transaksi pada Firebase
      await FirebaseFirestore.instance
          .collection('transaction')
          .doc(transactionId)
          .update({'orderStatus': 'Canceled'});

      showCustomToast('Transaction canceled successfully');

      ctx.pushReplacementNamed(paths.home);
    } catch (e) {
      print('Error deleting transaction: $e');
      showCustomToast('Failed to cancel the transaction. Please try again.',
          isError: true);
    }
  }

  @override
  FutureOr<void> init() {
    // TODO: implement init
    // throw UnimplementedError();
  }
}
