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
  Map<String, int> wasteWeight = {};

  Future<void> fetchUserData() async {
    try {
      currentAdmin = auth.FirebaseAuth.instance.currentUser;
      if (currentAdmin != null) {
        DocumentSnapshot adminDoc = await FirebaseFirestore.instance
            // .collection('admin')
            // .doc(currentAdmin!.uid)
            .collection('transaction')
            .doc(transactionID)
            .get();

        if (adminDoc.exists) {
          userID = adminDoc['userID'] ?? '';
          adminID = adminDoc['adminID'] ?? '';
          // print(userID);
          await fetchUserData2(userID);
          await fetchAdminData(adminID);
          notifyListeners();
        }
      }
    } catch (e) {
      showCustomToast('Error fetching user data: $e', isError: true);
    }
  }

  Future<void> fetchAdminData(String id) async {
    try {
      currentAdmin = auth.FirebaseAuth.instance.currentUser;
      if (currentAdmin != null) {
        DocumentSnapshot adminDoc =
            await FirebaseFirestore.instance.collection('admin').doc(id).get();

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

  Future<void> fetchUserData2(String id) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(id).get();

      if (userDoc.exists) {
        userFullName = userDoc['userName'] ?? '';
        userPhoneNum = userDoc['userPhoneNumber'] ?? '';
        userAddress = userDoc['userAddress'] ?? '';
        notifyListeners();
      }
    } catch (e) {
      showCustomToast('Error fetching user data: $e', isError: true);
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
  void initializeWasteQuantities(List<WasteCategoryModel> categories) {
    for (var category in categories) {
      wasteWeight[category.id] = 1; // Default quantity untuk setiap kategori
    }
    notifyListeners();
  }

  // Fungsi untuk meningkatkan kuantitas
  void increaseQuantity(String categoryId) {
    if (wasteWeight.containsKey(categoryId)) {
      wasteWeight[categoryId] = (wasteWeight[categoryId] ?? 0) + 1;
      notifyListeners();
    }
  }

  // Fungsi untuk mengurangi kuantitas
  void decreaseQuantity(String categoryId) {
    if (wasteWeight.containsKey(categoryId) &&
        (wasteWeight[categoryId] ?? 0) > 0) {
      wasteWeight[categoryId] = (wasteWeight[categoryId] ?? 0) - 1;
      notifyListeners();
    }
  }

  bool validateForm() {
    int totalQty = 0;
    for (var quantity in wasteWeight.values) {
      totalQty += quantity;
    }

    if (totalQty < 1) {
      showCustomToast('Waste categories must at least 1 kg', isError: true);
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
      final weight = wasteWeight.values.fold(0, (sum, qty) => sum + qty);
      final cardboardWeight = wasteWeight['IwoJoghBYQQrmTRThjlk'];
      final glassWeight = wasteWeight['uuk14PI0XvaD5jZfouvy'];
      final plasticWeight = wasteWeight['JEO10T6Zlo3tmYcIYIMR'];
      final point = transactionData.totalWastePcs * 100;

      if (!isSend) {
        ctx.pushNamed(paths.fillDropID, extra: <String, dynamic>{
          'adminID': adminID,
          'weight': weight,
          'point': point,
          'transactionData': transactionData,
          'cardboardWeight': cardboardWeight,
          'glassWeight': glassWeight,
          'plasticWeight': plasticWeight,
        });
        return;
      }

      // Data untuk disimpan ke Firestore
      final transactionUpdateData = {
        'earnPoints': point,
        'orderStatus': 'Verify',
        'totalWeight': weight,
        'cardboardWeight': cardboardWeight,
        'glassWeight': glassWeight,
        'plasticWeight': plasticWeight,
      };

      // Dapatkan referensi dokumen transaksi
      final transactionDocRef = FirebaseFirestore.instance
          .collection('transaction')
          .doc(transactionID);

      // Update dokumen transaksi
      await transactionDocRef.update(transactionUpdateData);

      // Navigasi berdasarkan kondisi `isSend`
      // if (!isSend) {
      //   ctx.pushNamed(paths.fillDropID);
      // } else {
      showCustomToast('Transaction verified successfully');
      ctx.pushNamed(paths.success, extra: <String, dynamic>{
        'isSend': isSend,
        'isAdmin': true,
        'point': point
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
    await fetchUserData();
    // await fetchAdminData();
    initializeWasteQuantities(wasteCategories);
  }
}
