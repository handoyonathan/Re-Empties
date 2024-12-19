import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
  bool loading = false;

  @override
  FutureOr<void> init() async {
    isLoading = true;
    await fetchAdminTransactionData();
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
      return transactions;
    }
    return transactions.where((transaction) {
      return transaction.transactionType == _selectedFilter;
    }).toList();
  }

  void setFilter(String filter) async {
    _selectedFilter = filter;
    loading = true;
    notifyListeners();

    try {
      await fetchAdminTransactionData(filter: _selectedFilter); // Fetch ulang data dari Firestore
      _filteredTransactions = filteredTransactions; // Terapkan filter
    } catch (e) {
      print('Error fetching data during filter: $e');
    } finally {
      loading = false;
      notifyListeners(); // Perbarui UI
    }
  }

  Future<void> fetchAdminTransactionData({String? filter}) async {
  try {
    currentAdmin = auth.FirebaseAuth.instance.currentUser;
    if (currentAdmin != null) {
      // Ambil adminID dari admin yang sedang login
      final adminID = currentAdmin!.uid;

      // Query Firestore untuk mendapatkan transaksi berdasarkan adminID
      Query query = FirebaseFirestore.instance
          .collection('transaction')
          .where('adminID', isEqualTo: adminID)
          ;

          if (filter != null && filter != 'All') {
          query = query.where('transactionType', isEqualTo: filter);
        }

        QuerySnapshot querySnapshot = await query.get();

      // Mapping transactions
      List<TransactionModel> tempTransactions = [];
      for (var doc in querySnapshot.docs) {
        TransactionModel transaction = TransactionModel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);

            final dateFormatter = DateFormat('EEEE, dd MMMM yyyy');
          final timeFormatter = DateFormat('HH:mm');

          final formattedDate = dateFormatter.format(transaction.dateTime);
          final formattedTime = timeFormatter.format(transaction.dateTime);

        // Assign the document ID (transactionId)
        transaction = transaction.copyWith(transactionId: doc.id);

        // Fetch user data untuk melengkapi detail transaksi
        if (transaction.userID.isNotEmpty) {
          await fetchUserData(transaction.userID);
          transaction = transaction.copyWith(
            name: userFullName,
            address: userAddress,
          );
        }

        tempTransactions.add(transaction);
      }

      tempTransactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));

      transactions = tempTransactions;
      _filteredTransactions = filteredTransactions; // Terapkan filter awal
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
