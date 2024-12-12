import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/components/custom_toast_mixin.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/send_empties/model/location_model.dart';
import 'package:re_empties/features/send_empties/model/transaction_model.dart';

class AdminViewVM extends BaseNotifier with CustomToastMixin {
  AdminViewVM(super.ref);
  auth.User? currentAdmin;
  List<TransactionModel> transactions = [];
  String userFullName = '';
  String userEmail = '';
  String userPhoneNum = '';
  String userAddress = '';
  late Admin adminData;

  @override
  FutureOr<void> init() {
    isLoading = true;
    fetchAdminTransactionData();
    isLoading = false;
  }

  Future<void> fetchUserData(String currentUserUid) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserUid)
          .get();

      if (userDoc.exists) {
        userFullName = userDoc['userName'] ?? '';
        userEmail = userDoc['userEmail'] ?? '';
        userPhoneNum = userDoc['userPhoneNumber'] ?? '';
        userAddress = userDoc['userAddress'] ?? '';
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> fetchAdminData(String currentAdminUid) async {
    try {
      DocumentSnapshot adminDoc = await FirebaseFirestore.instance
          .collection('admin')
          .doc(currentAdminUid)
          .get();

      if (adminDoc.exists) {
        adminData =
            Admin.fromFirestore(adminDoc.data() as Map<String, dynamic>);
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching admin data: $e');
    }
  }

  String? getCurrentAdminId() {
    final admin = FirebaseAuth.instance.currentUser;
    return admin?.uid;
  }

  String _selectedFilter = 'All';
  List<TransactionModel> _filteredTransactions = [];

  String get selectedFilter => _selectedFilter;
  List<TransactionModel> get filteredTransactions {
    if (_selectedFilter == 'All') {
      // print(transactions.toList());
      return transactions;
    }
    return transactions.where((transaction) {
      return transaction.transactionType == _selectedFilter;
    }).toList();
  }

  void setFilter(String filter) {
    _selectedFilter = filter;
    _filteredTransactions = filteredTransactions;
    notifyListeners();
  }

  Future<void> fetchAdminTransactionData() async {
    try {
      currentAdmin = auth.FirebaseAuth.instance.currentUser;
      if (currentAdmin != null) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('admin')
            .doc(currentAdmin!.uid)
            .collection('transactions')
            .get();

        // Mapping transactions
        List<TransactionModel> tempTransactions = [];
        for (var doc in querySnapshot.docs) {
          TransactionModel transaction = TransactionModel.fromFirestore(
              doc.data() as Map<String, dynamic>, doc.id);

          // print(
          //     'Transaction ID: ${transaction.transactionId}, Type: ${transaction.transactionType}');

          // Assign the document ID (transactionId)
          transaction = transaction.copyWith(transactionId: doc.id);

          // Fetch user data for address
          if (transaction.userID.isNotEmpty) {
            await fetchUserData(transaction.userID);
            transaction = transaction.copyWith(
              name: userFullName,
              address: userAddress,
            );
          }
          tempTransactions.add(transaction);
        }

        transactions = tempTransactions;
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching transaction admin data: $e');
    }
  }

  late bool send;

  void goToTransactionDetailPage({
    required bool? isSend,
    required TransactionModel transaction,
  }) async {
    send = isSend ?? false;

    await fetchAdminData(getCurrentAdminId()!);

    ctx.pushNamed(paths.transactionDetail, extra: <String, dynamic>{
      'admin': adminData,
      'transaction': transaction,
      'isSend': isSend,
      'transactionID': transaction.transactionId,
    });
  }
}
