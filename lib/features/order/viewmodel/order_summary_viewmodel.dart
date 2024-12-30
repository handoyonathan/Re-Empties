import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:re_empties/cores/components/alert_dialog.dart';
import 'package:re_empties/cores/components/custom_toast_mixin.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/send_empties/model/transaction_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class OrderSummaryVM extends BaseNotifier with CustomToastMixin {
  final String transactionID;
  OrderSummaryVM(super.ref, {required this.transactionID});

  TransactionModel? transaction;
  auth.User? currentUser;
  String userFullName = '';
  String userPhoneNum = '';
  String userAddress = '';
  String adminFullName = '';
  String adminPhoneNum = '';
  String adminAddress = '';
  String formattedDate = '';
  String formattedTime = '';

  bool isError = false;

  @override
  FutureOr<void> init() async {
    isLoading = true;
    await fetchTransactionData();
    if (transaction != null) {
      await fetchUserData();
      await fetchAdminData();
    }
    isLoading = false;
  }

  Future<void> fetchUserData() async {
    try {
      currentUser = auth.FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .get();

        if (userDoc.exists) {
          userFullName = userDoc['userName'] ?? '';
          userPhoneNum = userDoc['userPhoneNumber'] ?? '';
          userAddress = userDoc['userAddress'] ?? '';
          notifyListeners();
        }
      }
    } catch (e) {
      showCustomToast('Error fetching user data: $e', isError: true);
      isError = true;
      notifyListeners();
    }
  }

  Future<void> fetchAdminData() async {
    try {
      if (transaction != null) {
        DocumentSnapshot adminDoc = await FirebaseFirestore.instance
            .collection('admin')
            .doc(transaction!.adminID)
            .get();

        if (adminDoc.exists) {
          adminFullName = adminDoc['stationName'] ?? '';
          adminPhoneNum = adminDoc['adminPhone'] ?? '';
          adminAddress = adminDoc['addressStation'] ?? '';
          notifyListeners();
        }
      }
    } catch (e) {
      showCustomToast('Error fetching admin data: $e', isError: true);
      isError = true;
      notifyListeners();
    }
  }

  Future<void> fetchTransactionData() async {
    try {
      // Query Firestore for the transaction document based on transactionID
      DocumentSnapshot query = await FirebaseFirestore.instance
          .collection('transaction')
          .doc(transactionID)
          .get();

      // Check if the document exists
      if (query.exists) {
        // Get the data from the Firestore document
        var data = query.data() as Map<String, dynamic>;

        // Create the TransactionModel from Firestore data
        transaction = TransactionModel.fromFirestore(data, query.id);

        // Format date and time
        final DateFormat dateFormatter = DateFormat('EEEE, dd MMMM yyyy');
        final DateFormat timeFormatter = DateFormat('HH:mm');

        formattedDate = dateFormatter.format(transaction!.dateTime);
        formattedTime = timeFormatter.format(transaction!.dateTime);

        // Log or use the formatted date and time as needed
        print('Formatted Date: $formattedDate');
        print('Formatted Time: $formattedTime');
      } else {
        print('Transaction not found for ID: $transactionID');
      }
    } catch (e) {
      print('Error fetching transaction data: $e');
      isError = true;
      notifyListeners();
    }
  }


  void deleteTransaction() async {
    try {
      // Referensi transaksi pada Firebase
      await FirebaseFirestore.instance
          .collection('transaction')
          .doc(transactionID)
          .update({'orderStatus': 'Canceled'});

      showCustomToast('Transaction canceled successfully');

      // ctx.goNamed(paths.home);
      ctx.pop('refresh');
    } catch (e) {
      print('Error deleting transaction: $e');
      showCustomToast('Failed to cancel the transaction. Please try again.',
          isError: true);
    }
  }

  void showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          onConfirm: () {
            Navigator.of(context).pop();
            deleteTransaction();
            print('masuk confirm');
          },
          onCancel: () {
            Navigator.of(context).pop();
            print('masuk cancel');
          },
        );
      },
    );
  }
}
