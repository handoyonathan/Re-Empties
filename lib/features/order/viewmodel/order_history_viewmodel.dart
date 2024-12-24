import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:re_empties/features/send_empties/model/location_model.dart';
import 'package:re_empties/features/send_empties/model/transaction_model.dart';

class OrderHistoryVM extends BaseNotifier {
  OrderHistoryVM(super.ref);

  auth.User? currentUser;
  List<TransactionModel> transactions = [];
  String date = '';
  String time = '';
  late List<Admin> adminData;
  String _selectedFilter = 'All';
  String selectedTab = 'All';
  bool isDataLoaded = false;

  String get selectedFilter => _selectedFilter;

  List<TransactionModel> get filteredTransactions => transactions;

  StreamSubscription? _transactionSubscription;

  @override
  FutureOr<void> init() async {
    isLoading = true;
    await fetchUserTransactionData();
    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _transactionSubscription?.cancel();
    super.dispose();
  }

  void setFilter(String filter) async {
    _selectedFilter = filter;
    notifyListeners();
    await fetchUserTransactionData(filter: filter, tab: selectedTab);
  }

  void refreshData() async {
    isLoading = true;
    notifyListeners();
    await fetchUserTransactionData(filter: _selectedFilter, tab: selectedTab);
    isLoading = false;
    notifyListeners();
  }

  void gotoDetail(int index) async {
    final result = await ctx.pushNamed(paths.transactionHistoryDetail, extra: {
      'transactionID': filteredTransactions[index].transactionId,
    });

    if (result == 'refresh') {
      refreshData();
    }
  }

  void setTab(String tab) async {
    selectedTab = tab;
    notifyListeners();
    await fetchUserTransactionData(filter: _selectedFilter, tab: tab);
  }

  Future<void> fetchUserTransactionData({
    String? filter,
    String? tab,
  }) async {
    try {
      currentUser = auth.FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        _transactionSubscription?.cancel();

        Query query = FirebaseFirestore.instance
            .collection('transaction')
            .where('userID', isEqualTo: currentUser!.uid);

        if (tab != null && tab != 'All') {
          query = query.where('orderStatus', isEqualTo: tab);
        }

        if (filter != null && filter != 'All') {
          query = query.where('transactionType', isEqualTo: filter);
        }

        _transactionSubscription =
            query.snapshots().listen((querySnapshot) async {
          List<TransactionModel> tempTransactions = [];
          Map<String, Admin?> tempAdminData = {};

          for (var doc in querySnapshot.docs) {
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

          // Sort transactions berdasarkan dateTime (descending)
          tempTransactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));

          // Update transaksi dan admin data ke state
          transactions = tempTransactions;

          // Perbarui adminData berdasarkan urutan transaction
          adminData = transactions.map((transaction) {
            return tempAdminData[transaction.transactionId]!;
          }).toList();

          isDataLoaded = true;
          notifyListeners();
        });
      }
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
    return null;
  }
}
