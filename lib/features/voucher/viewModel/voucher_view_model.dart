// voucherViewModel.dart
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/components/custom_toast_mixin.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/voucher/model/voucher_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class VoucherViewModel extends BaseNotifier with CustomToastMixin {
  VoucherViewModel(super.ref);

  auth.User? currentUser;
  int point = 0;
  List<Voucher> vouchers = [];
  StreamSubscription? _userPointSubscription;
  StreamSubscription? _voucherSubscription;

  @override
  FutureOr<void> init() async {
    isLoading = true;
    await fetchVoucherData();
    await fetchUserPoint();
    isLoading = false;
  }

  Future<void> fetchUserPoint() async {
    try {
      currentUser = auth.FirebaseAuth.instance.currentUser;
      _userPointSubscription = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .snapshots()
          .listen((doc) async {
        if (doc.exists && doc.data() != null) {
          point = doc.data()?['rewardPoint'];
          notifyListeners();
        }
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> fetchVoucherData() async {
    try {
      _voucherSubscription = FirebaseFirestore.instance
          .collection('vouchers')
          .snapshots()
          .listen((query) async {
        vouchers = query.docs
            .map((doc) =>
                Voucher.fromFireStore(doc.data(), doc.id))
            .toList();
        sortVouchers();
      });
    } catch (e) {
      print("Error fetching voucher: $e");
    }
  }

  void sortVouchers() {
  vouchers.sort((a, b) {
    // Prioritas: Stok masih ada > Sudah dipakai > Out of stock
    if (!isVoucherOutOfStock(a) && !isVoucherUsed(a)) return -1; // Stok masih ada dan belum dipakai
    if (!isVoucherOutOfStock(b) && !isVoucherUsed(b)) return 1;

    if (isVoucherUsed(a)) return -1; // Sudah dipakai
    if (isVoucherUsed(b)) return 1;

    if (isVoucherOutOfStock(a)) return 1; // Out of stock
    if (isVoucherOutOfStock(b)) return -1;

    return 0; // Default
  });
  notifyListeners();
}

  bool isVoucherUsed(Voucher voucher) {
    return voucher.userUsed?.contains(currentUser?.uid) ?? false;
  }

  bool isVoucherOutOfStock(Voucher voucher) {
    return voucher.stock <= 0;
  }

  void goToDetailVoucher(int index) {
    ctx.pop();
    if (checkPoint(index)) {
      showCustomToast('Not enough points to redeem this voucher', isError: true);
      return;
    }
    ctx.pushNamed(paths.voucherDetail, extra: vouchers[index].voucherID);
  }

  bool checkPoint(int index){
    return point < int.parse(vouchers[index].points) ? true : false;
  }

  @override
  void dispose() {
    _userPointSubscription?.cancel();
    _voucherSubscription?.cancel();
    super.dispose();
  }
}
