import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:re_empties/cores/components/custom_toast_mixin.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/send_empties/model/delivery_model.dart';
import 'package:re_empties/features/send_empties/model/location_model.dart';
import 'package:re_empties/features/send_empties/model/payment_model.dart';
import 'package:re_empties/features/send_empties/model/waste_category.dart';
import 'package:re_empties/features/send_empties/widget/bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserFormVM extends BaseNotifier with CustomToastMixin {
  UserFormVM(super.ref);

  int? selectedPaymentMethod;
  int? selectedDeliveryMethod;
  String selectedPaymentTitle = 'Select Payment';
  String selectedDeliveryTitle = 'Select Delivery';
  List<WasteCategoryModel> wasteCategories = [];

  auth.User? currentUser;
  String userFullName = '';
  String userPhoneNum = '';
  String userAddress = '';

  // Properti terkait quantity
  Map<String, int> wasteQuantities = {};

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

  Future<List<PaymentOptionModel>> fetchPaymentOptions() async {
    List<PaymentOptionModel> paymentOptions = [];
    final paymentCollection = FirebaseFirestore.instance.collection('payment');
    final snapshot = await paymentCollection.get();

    for (var doc in snapshot.docs) {
      paymentOptions.add(PaymentOptionModel.fromFirestore(doc.data()));
    }

    return paymentOptions;
  }

  Future<List<DeliveryOptionModel>> fetchDeliveryOptions() async {
    List<DeliveryOptionModel> deliveryOptions = [];
    final deliveryCollection =
        FirebaseFirestore.instance.collection('delivery');
    final snapshot = await deliveryCollection.get();

    for (var doc in snapshot.docs) {
      deliveryOptions.add(DeliveryOptionModel.fromFirestore(doc.data()));
    }

    return deliveryOptions;
  }

  Future<void> showPaymentOptions() async {
    try {
      List<PaymentOptionModel> paymentOptions = await fetchPaymentOptions();
      showOptionsModal(
        context: ctx,
        options: paymentOptions,
        selectedValue: selectedPaymentMethod ?? 0,
        onSelected: (int value) {
          selectPaymentMethod(value, paymentOptions[value].title);
        },
      );
    } catch (e) {
      showCustomToast("Error fetching payment options: $e", isError: true);
    }
  }

  Future<void> showDeliveryOptions() async {
    try {
      List<DeliveryOptionModel> deliveryOptions = await fetchDeliveryOptions();
      showOptionsModal(
        context: ctx,
        options: deliveryOptions,
        selectedValue: selectedDeliveryMethod ?? 0,
        onSelected: (int value) {
          selectDeliveryMethod(value, deliveryOptions[value].title);
        },
      );
    } catch (e) {
      showCustomToast("Error fetching delivery options: $e", isError: true);
    }
  }

  void selectPaymentMethod(int value, String title) {
    selectedPaymentMethod = value;
    selectedPaymentTitle = title;
    notifyListeners();
  }

  void selectDeliveryMethod(int value, String title) {
    selectedDeliveryMethod = value;
    selectedDeliveryTitle = title;
    notifyListeners();
  }

  // Fungsi untuk mengatur kuantitas awal
  void initializeWasteQuantities(List<WasteCategoryModel> categories) {
    for (var category in categories) {
      wasteQuantities[category.id] =
          1; // Default quantity untuk setiap kategori
    }
    notifyListeners();
  }

  // Fungsi untuk meningkatkan kuantitas
  void increaseQuantity(String categoryId) {
    if (wasteQuantities.containsKey(categoryId)) {
      wasteQuantities[categoryId] = (wasteQuantities[categoryId] ?? 0) + 1;
      notifyListeners();
    }
  }

  // Fungsi untuk mengurangi kuantitas
  void decreaseQuantity(String categoryId) {
    if (wasteQuantities.containsKey(categoryId) &&
        (wasteQuantities[categoryId] ?? 0) > 0) {
      wasteQuantities[categoryId] = (wasteQuantities[categoryId] ?? 0) - 1;
      notifyListeners();
    }
  }

  bool validateForm() {
    int totalQty = 0;
    for (var quantity in wasteQuantities.values) {
      totalQty += quantity;
    }

    if (totalQty < 1) {
      showCustomToast('Waste categories must at least 1 quantity',
          isError: true);
      return false;
    }

    if (send) {
      if (selectedDeliveryMethod == null) {
        showCustomToast('Choose at least one delivery method', isError: true);
        return false;
      }
      if (selectedPaymentMethod == null) {
        showCustomToast('Choose at least one payment method', isError: true);
        return false;
      }
    }

    return true;
  }

  late bool send;
  late var transactionId;

  Future<void> saveTransaction({
    required String adminID,
    required Map<String, dynamic> transactionData,
  }) async {
    try {
      // Simpan data transaksi di dalam subkoleksi `transaction` milik admin
      transactionId = await FirebaseFirestore.instance
          .collection('admin')
          .doc(adminID)
          .collection('transactions')
          .add(transactionData);

      showCustomToast('Transaction saved successfully');
    } catch (e) {
      showCustomToast('Error saving transaction: $e', isError: true);
    }
  }

  void goToSuccessPage({
    required bool? isSend,
    required Admin wasteLocation,
    required String adminID,
    required double currentLat,
    required double currentLong,
  }) async {
    send = isSend ?? false;

    if (validateForm()) {
      final weight = wasteQuantities.values.fold(0, (sum, qty) => sum + qty);
      final point = weight * 100;
      final transactionData = {
        'userID': currentUser?.uid ?? '',
        'adminID': adminID,
        'cardboardWeight': wasteQuantities['IwoJoghBYQQrmTRThjlk'],
        'currenLocationLat': currentLat,
        'currenLocationLong': currentLong,
        'dateTime': DateTime.now(),
        'deliveryFee': send ? 10000 : null,
        'deliveryOption': send ? selectedDeliveryTitle : null,
        'earnPoints': point,
        'glassWeight': wasteQuantities['uuk14PI0XvaD5jZfouvy'],
        'orderStatus': 'Done',
        'paymentType': selectedPaymentTitle,
        'plasticWeight': wasteQuantities['JEO10T6Zlo3tmYcIYIMR'],
        'totalWeight': weight,
        'transactionType': send ? 'Send' : 'Drop',
      };

      await saveTransaction(adminID: adminID, transactionData: transactionData);

      if (send) {
        ctx.pushNamed(paths.success, extra: <String, dynamic>{
          'isSend': isSend,
        });
        return;
      }

      // Jika tidak send, pindah ke halaman drop point detail
      ctx.pushNamed(paths.dropPointDetail, extra: <String, dynamic>{
        'wasteLocation': wasteLocation,
        'isSend': isSend,
        'transactionID': transactionId.id,
      });
    }
  }

  @override
  FutureOr<void> init() async {
    await fetchWasteCategories();
    await fetchUserData();
    initializeWasteQuantities(wasteCategories);
  }
}
