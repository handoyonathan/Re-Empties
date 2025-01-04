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
  Map<String, String> transactionUserName = {};
  Map<String, String> transactionUserAddress = {};
  bool isDataLoaded = false;

  StreamSubscription? _transactionStreamSubscription;

  @override
  FutureOr<void> init() async {
    isLoading = true;
    await fetchAdminTransactionData();
    isLoading = false;
  }

  @override
  void dispose() {
    // Batalkan stream listener ketika ViewModel dihapus
    _transactionStreamSubscription?.cancel();
    _transactionStreamSubscription = null;
    super.dispose();
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
    isDataLoaded = false;

    try {
      await fetchAdminTransactionData(filter: _selectedFilter);
      _filteredTransactions = filteredTransactions;
    } catch (e) {
      print('Error fetching data during filter: $e');
    } finally {
      isDataLoaded = true;
      notifyListeners();
    }
  }

  Future<void> fetchAdminTransactionData({String? filter}) async {
    try {
      isDataLoaded = false;
      currentAdmin = auth.FirebaseAuth.instance.currentUser;
      if (currentAdmin != null) {
        final adminID = currentAdmin!.uid;

        Query query = FirebaseFirestore.instance
            .collection('transaction')
            .where('adminID', isEqualTo: adminID)
            .where('orderStatus', isEqualTo: 'Delivery');

        if (filter != null && filter != 'All') {
          query = query.where('transactionType', isEqualTo: filter);
        }

        // Batalkan listener sebelumnya jika ada
        _transactionStreamSubscription?.cancel();

        _transactionStreamSubscription = query.snapshots().listen((querySnapshot) async {
          List<TransactionModel> tempTransactions = [];
          Map<String, String> tempName = {};
          Map<String, String> tempAddress = {};

          for (var doc in querySnapshot.docs) {
            TransactionModel transaction = TransactionModel.fromFirestore(
                doc.data() as Map<String, dynamic>, doc.id);

            transaction = transaction.copyWith(transactionId: doc.id);

            if (transaction.userID.isNotEmpty) {
              try {
                DocumentSnapshot userDoc = await FirebaseFirestore.instance
                    .collection('users')
                    .doc(transaction.userID)
                    .get();

                if (userDoc.exists) {
                  tempName[transaction.transactionId] =
                      userDoc['userName'] ?? 'Unknown';
                  tempAddress[transaction.transactionId] =
                      userDoc['userAddress'] ?? 'Unknown';
                }
              } catch (e) {
                print(
                    'Error fetching user data for transaction ${transaction.transactionId}: $e');
              }
            }

            tempTransactions.add(transaction);
          }

          tempTransactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));

          transactions = tempTransactions;
          transactionUserName = tempName;
          transactionUserAddress = tempAddress;
          _filteredTransactions = filteredTransactions;
          isDataLoaded = true;

          // Pastikan hanya memanggil notifyListeners jika masih ada listener
          if (hasListeners) notifyListeners();
        });
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
