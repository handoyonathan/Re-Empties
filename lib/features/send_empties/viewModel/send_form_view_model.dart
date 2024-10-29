import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/send_empties/model/delivery_model.dart';
import 'package:re_empties/features/send_empties/model/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:re_empties/features/send_empties/model/waste_category.dart';
import 'package:re_empties/features/send_empties/widget/bottom_sheet.dart';

class SendFormVM extends BaseNotifier {
  SendFormVM(super.ref);

  int selectedPaymentMethod = 0;
  int selectedDeliveryMethod = 0;
  String selectedPaymentTitle = 'Select Payment';
  String selectedDeliveryTitle = 'Select Delivery';
  List<WasteCategoryModel> wasteCategories = [];

  Future<void> fetchWasteCategories() async {
    final wasteCategoryCollection = FirebaseFirestore.instance.collection('wasteCategory');
    final snapshot = await wasteCategoryCollection.get();

    wasteCategories = snapshot.docs
        .map((doc) => WasteCategoryModel.fromFirestore(doc.data()))
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
    final deliveryCollection = FirebaseFirestore.instance.collection('delivery');
    final snapshot = await deliveryCollection.get();

    for (var doc in snapshot.docs) {
      deliveryOptions.add(DeliveryOptionModel.fromFirestore(doc.data()));
    }

    return deliveryOptions;
  }

  Future<void> showPaymentOptions(BuildContext context) async {
    try {
      List<PaymentOptionModel> paymentOptions = await fetchPaymentOptions();
      showOptionsModal(
        context: context,
        options: paymentOptions,
        selectedValue: selectedPaymentMethod,
        onSelected: (int value) {
          selectPaymentMethod(value, paymentOptions[value].title);
        },
      );
    } catch (e) {
      print("Error fetching payment options: $e");
    }
  }

  Future<void> showDeliveryOptions(BuildContext context) async {
    try {
      List<DeliveryOptionModel> deliveryOptions = await fetchDeliveryOptions();
      showOptionsModal(
        context: context,
        options: deliveryOptions,
        selectedValue: selectedDeliveryMethod,
        onSelected: (int value) {
          selectDeliveryMethod(value, deliveryOptions[value].title);
        },
      );
    } catch (e) {
      print("Error fetching delivery options: $e");
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

  @override
  FutureOr<void> init() {
    fetchWasteCategories();
  }
}
