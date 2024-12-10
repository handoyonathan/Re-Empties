import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/send_empties/model/transaction_model.dart';

class AdminViewVM extends BaseNotifier {
  AdminViewVM(super.ref);
  auth.User? currentAdmin;
  List<TransactionModel> transactions = [];
  // auth.User? currentUser;
  String userFullName = '';
  String userEmail = '';
  String userPhoneNum = '';
  String userAddress = '';

  @override
  FutureOr<void> init() {
    isLoading = true;
    fetchAdminTransactionData();
    print('uhuy');
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
        TransactionModel transaction = TransactionModel.fromFirestore(doc.data() as Map<String, dynamic>);

        // Ambil userAddress menggunakan fetchUserData
        if (transaction.userID.isNotEmpty) {
          await fetchUserData(transaction.userID);
          transaction = TransactionModel(
            userID: transaction.userID,
            adminID: transaction.adminID,
            cardboardWeight: transaction.cardboardWeight,
            currentLocationLat: transaction.currentLocationLat,
            currentLocationLong: transaction.currentLocationLong,
            dateTime: transaction.dateTime,
            deliveryFee: transaction.deliveryFee,
            deliveryOption: transaction.deliveryOption,
            earnPoints: transaction.earnPoints,
            glassWeight: transaction.glassWeight,
            orderStatus: transaction.orderStatus,
            paymentType: transaction.paymentType,
            plasticWeight: transaction.plasticWeight,
            totalWeight: transaction.totalWeight,
            transactionType: transaction.transactionType,
            dropID: transaction.dropID,
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

}
