import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/send_empties/model/location_model.dart';
import 'package:re_empties/features/send_empties/model/transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class DashboardVM extends BaseNotifier {
  DashboardVM(super.ref);
  auth.User? currentUser;
  TransactionModel? transactions;
  Admin? adminData;
  bool isDataLoaded = false; // Flag untuk menandakan data sudah dimuat

  Future<void> checkLoginStatus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    bool isUserLoggedIn = prefs.getBool('isUserLoggedIn') ?? false;

    if (!isUserLoggedIn) {
      ctx.goNamed(paths.login);
    }
  }

  void goToIntroPage({bool? isSend}) {
    ctx.pushNamed(paths.intro, extra: isSend);
  }

  Future<void> fetchUserTransactionData() async {
    try {
      currentUser = auth.FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Ambil semua data transaksi tanpa menggunakan orderBy
        QuerySnapshot query = await FirebaseFirestore.instance
            .collection('transaction')
            .where(
              'userID',
              isEqualTo: currentUser!.uid,
            )
            .where('orderStatus', isEqualTo: 'Delivery')
            .get();

        List<TransactionModel> tempTransactions = [];
        Map<String, Admin?> tempAdminData = {};

        for (var doc in query.docs) {
          TransactionModel transaction = TransactionModel.fromFirestore(
            doc.data() as Map<String, dynamic>,
            doc.id,
          );

          // Format date dan time
          final dateFormatter = DateFormat('EEEE, dd MMMM yyyy');
          final timeFormatter = DateFormat('HH:mm');

          final formattedDate = dateFormatter.format(transaction.dateTime);
          final formattedTime = timeFormatter.format(transaction.dateTime);

          transaction = transaction.copyWith(
            date: formattedDate,
            time: formattedTime,
          );

          // Fetch admin data jika adminID ada
          if (transaction.adminID.isNotEmpty) {
            Admin? admin = await fetchAdminData(transaction.adminID);
            tempAdminData[transaction.transactionId] = admin;
          }

          tempTransactions.add(transaction);
        }

        // Urutkan transaksi berdasarkan dateTime secara lokal
        tempTransactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));

        // Ambil transaksi pertama setelah pengurutan, yang paling terkini
        if (tempTransactions.isNotEmpty) {
          transactions = tempTransactions.first;

          // Perbarui adminData untuk transaksi terkini
          adminData = tempAdminData[transactions!.transactionId];
        }
      }

      // Menandakan bahwa data telah selesai dimuat
      isDataLoaded = true;
    } catch (e) {
      print('Error fetching transaction data: $e');
    }
  }

  Future<Admin?> fetchAdminData(String currentAdminUid) async {
    try {
      DocumentSnapshot adminDoc = await FirebaseFirestore.instance
          .collection('admin')
          .doc(currentAdminUid)
          .get();

      if (adminDoc.exists) {
        return Admin.fromFirestore(adminDoc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print('Error fetching admin data: $e');
    }
    return null; // Jika tidak ada data admin, kembalikan null
  }

  void gotoDetail(){
    ctx.pushNamed(paths.transactionHistoryDetail, extra: <String, dynamic>{
      'transactionID': transactions!.transactionId
    });
  }

  @override
  FutureOr<void> init() async {
    isLoading = true;
    await fetchUserTransactionData();
    checkLoginStatus(ctx);
    isLoading = false;
  }
}
