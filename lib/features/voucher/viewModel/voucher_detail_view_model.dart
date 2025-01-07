import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/components/custom_toast_mixin.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/voucher/model/voucher_model.dart';

class VoucherDetailViewModel extends BaseNotifier with CustomToastMixin {
  VoucherDetailViewModel(super.ref, {required this.voucherId});

  final String voucherId;
  bool isDataLoaded = false;

  @override
  FutureOr<void> init() {
    isLoading = true;
    fetchVoucherData();
    isLoading = false;
    // TODO: implement init
    // throw UnimplementedError();
  }

  late Voucher vouchers;

  void fetchVoucherData() {
    try {
      FirebaseFirestore.instance
          .collection('vouchers')
          .doc(voucherId)
          .snapshots()
          .listen((query) async {
        vouchers = Voucher.fromFireStore(
            query.data() as Map<String, dynamic>, voucherId);
        isDataLoaded = true;
        notifyListeners();
      });
    } catch (e) {
      print("error fetching voucher: $e");
    }
  }

  void backToList() {
    ctx.pop();
  }

  void useVoucher() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final voucherRef =
            FirebaseFirestore.instance.collection('vouchers').doc(voucherId);
        final userRef =
            FirebaseFirestore.instance.collection('users').doc(userId);

        final voucherSnapshot = await transaction.get(voucherRef);
        if (!voucherSnapshot.exists) {
          throw Exception("Voucher not found");
        }

        final userSnapshot = await transaction.get(userRef);
        if (!userSnapshot.exists) {
          throw Exception("User not found");
        }

        final voucherData = voucherSnapshot.data()!;
        final currentStock = voucherData['stock'] ?? 0;
        final voucherPoints =
            int.tryParse(voucherData['voucherPoint'].toString()) ?? 0;
        final userUsed = List<String>.from(voucherData['userUsed'] ?? []);

        final userData = userSnapshot.data()!;
        final currentPoints = userData['rewardPoint'] ?? 0;

        print('test curr point:$currentPoints');
        print('test voucher point:$voucherPoints');
        if (currentPoints < voucherPoints) {
          showCustomToast('Not enough points to redeem this voucher',
              isError: true);
          return;
        }

        if (!userUsed.contains(userId)) {
          userUsed.add(userId!);
        }

        // Update stok, userUsed di voucher, dan rewardPoint di user
        transaction.update(voucherRef, {
          'stock': currentStock - 1,
          'userUsed': userUsed,
        });

        transaction.update(userRef, {
          'rewardPoint': currentPoints - voucherPoints,
        });
        showCustomToast('Voucher claimed successfully');
        ctx.pop();
      });

      // Notifikasi sukses
      // showCustomToast('Voucher claimed successfully');
      // ctx.pop();
    } catch (e) {
      print("Error using voucher: $e");
      showCustomToast('Failed to claim voucher');
    }
  }
}
