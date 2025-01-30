import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/components/custom_toast_mixin.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/send_empties/model/transaction_model.dart';
import 'package:re_empties/features/send_empties/model/waste_category.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class TransactionDetailVM extends BaseNotifier with CustomToastMixin {
  final String transactionID;

  TransactionDetailVM(
    super.ref, {
    required this.transactionID,
  });

  List<WasteCategoryModel> wasteCategories = [];

  auth.User? currentAdmin;
  String userFullName = '';
  String userPhoneNum = '';
  String userAddress = '';
  String userID = '';

  String adminName = '';
  String adminPhoneNum = '';
  String adminAddress = '';
  String adminID = '';

  // Properti terkait quantity
  Map<String, int> wastePcs = {};

  Future<void> fetchTransactionDetail() async {
    try {
      currentAdmin = auth.FirebaseAuth.instance.currentUser;
      if (currentAdmin != null) {
        DocumentSnapshot transactionDoc = await FirebaseFirestore.instance
            .collection('transaction')
            .doc(transactionID)
            .get();

        if (transactionDoc.exists) {
          userID = transactionDoc['userID'] ?? '';
          adminID = transactionDoc['adminID'] ?? '';

          print('Transaction details fetched successfully.');
          print('UserID: $userID, AdminID: $adminID');

          // Call the respective functions to fetch additional data
          await fetchUserData(userID);
          await fetchAdminData(adminID);

          notifyListeners();
        } else {
          print('Transaction document does not exist.');
        }
      }
    } catch (e) {
      print('Error fetching transaction details: $e');
    }
  }

  Future<void> fetchUserData(String userID) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .get();

      if (userDoc.exists) {
        userFullName = userDoc['userName'] ?? '';
        userPhoneNum = userDoc['userPhoneNumber'] ?? '';
        userAddress = userDoc['userAddress'] ?? '';
        notifyListeners();
      } else {
        print('User document does not exist.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> fetchAdminData(String adminID) async {
    try {
      currentAdmin = auth.FirebaseAuth.instance.currentUser;
      if (currentAdmin != null) {
        DocumentSnapshot adminDoc = await FirebaseFirestore.instance
            .collection('admin')
            .doc(adminID)
            .get();

        if (adminDoc.exists) {
          adminID = currentAdmin!.uid;
          adminName = adminDoc['stationName'];
          adminPhoneNum = adminDoc['adminPhone'];
          adminAddress = adminDoc['addressStation'];
          notifyListeners();
        }
      }
    } catch (e) {
      showCustomToast('Error fetching admin data: $e', isError: true);
    }
  }

  Future<void> fetchWasteCategories() async {
    final wasteCategoryCollection =
        FirebaseFirestore.instance.collection('wasteCategory');
    final snapshot = await wasteCategoryCollection.get();

    wasteCategories = snapshot.docs
        .map((doc) =>
            WasteCategoryModel.fromFirestore(doc.data(), docId: doc.id))
        .toList();
    notifyListeners();
  }

  // Fungsi untuk mengatur kuantitas awal
  Future<void> initializeWasteQuantitiesFromTransaction() async {
    try {
      // Ambil data transaksi berdasarkan transactionID
      DocumentSnapshot transactionDoc = await FirebaseFirestore.instance
          .collection('transaction')
          .doc(transactionID)
          .get();

      if (transactionDoc.exists) {
        // Ambil nilai kuantitas dari dokumen transaksi
        int cardboardPcs = transactionDoc['cardboardPcs'];
        int glassPcs = transactionDoc['glassPcs'];
        int plasticPcs = transactionDoc['plasticPcs'];

        // Tetapkan nilai ke wastePcs berdasarkan kategori
        wastePcs = {
          'IwoJoghBYQQrmTRThjlk': cardboardPcs, // ID kategori untuk cardboard
          'uuk14PI0XvaD5jZfouvy': glassPcs, // ID kategori untuk glass
          'JEO10T6Zlo3tmYcIYIMR': plasticPcs, // ID kategori untuk plastic
        };

        notifyListeners();
      }
      // else {
      // showCustomToast('Transaction not found', isError: true);
      // }
    } catch (e) {
      showCustomToast('Error initializing waste quantities: $e', isError: true);
    }
  }

  // Fungsi untuk meningkatkan kuantitas
  void increaseQuantity(String categoryId) {
    if (wastePcs.containsKey(categoryId)) {
      wastePcs[categoryId] = (wastePcs[categoryId] ?? 0) + 1;
      notifyListeners();
    }
  }

  // Fungsi untuk mengurangi kuantitas
  void decreaseQuantity(String categoryId) {
    if (wastePcs.containsKey(categoryId) && (wastePcs[categoryId] ?? 0) > 0) {
      wastePcs[categoryId] = (wastePcs[categoryId] ?? 0) - 1;
      notifyListeners();
    }
  }

  bool validateForm() {
    int totalQty = 0;
    for (var quantity in wastePcs.values) {
      totalQty += quantity;
    }

    if (totalQty < 1) {
      showCustomToast('Waste categories must at least 1 pcs', isError: true);
      return false;
    }

    return true;
  }

  void saveTransaction({
    required String adminID,
    required TransactionModel transactionData,
    required bool isSend,
  }) async {
    try {
      // Validasi form
      if (!validateForm()) return;

      // Hitung total berat dan poin
      final Pcs = wastePcs.values.fold(0, (sum, qty) => sum + qty);
      final cardboardPcs = wastePcs['IwoJoghBYQQrmTRThjlk'];
      final glassPcs = wastePcs['uuk14PI0XvaD5jZfouvy'];
      final plasticPcs = wastePcs['JEO10T6Zlo3tmYcIYIMR'];
      final point = Pcs * 100;

      if (!isSend) {
        ctx.pushNamed(paths.fillDropID, extra: <String, dynamic>{
          'adminID': adminID,
          'totalPcs': Pcs,
          'point': point,
          'transactionData': transactionData,
          'cardboardWeight': cardboardPcs,
          'glassWeight': glassPcs,
          'plasticWeight': plasticPcs,
        });
        return;
      }

      // Data untuk disimpan ke Firestore
      final transactionUpdateData = {
        'earnPoints': point,
        'orderStatus': 'Verify',
        'totalWastePcs': Pcs,
        'cardboardPcs': cardboardPcs,
        'glassPcs': glassPcs,
        'plasticPcs': plasticPcs,
      };

      // Dapatkan referensi dokumen transaksi
      final transactionDocRef = FirebaseFirestore.instance
          .collection('transaction')
          .doc(transactionID);

      // Update dokumen transaksi
      await transactionDocRef.update(transactionUpdateData);

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
      // showCustomToast('Transaction verified successfully');
      ctx.pushNamed(paths.success, extra: <String, dynamic>{
        'isSend': isSend,
        'isAdmin': true,
        // 'point': point
      });
      // }
    } catch (e) {
      // Tangani error dan tampilkan notifikasi error
      showCustomToast('Error verify transaction: $e', isError: true);
    }
  }

  @override
  FutureOr<void> init() async {
    await fetchWasteCategories();
    await fetchTransactionDetail();
    // await fetchAdminData();
    // initializeWasteQuantities(wasteCategories);
    await initializeWasteQuantitiesFromTransaction();
  }
}
