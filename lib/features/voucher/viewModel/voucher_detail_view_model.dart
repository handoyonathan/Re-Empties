import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/voucher/model/voucher_model.dart';

class VoucherDetailViewModel extends BaseNotifier {
  VoucherDetailViewModel(super.ref, {required this.voucherId});

  final String voucherId;

  @override
  FutureOr<void> init() async {
    isLoading = true;
    await fetchVoucherData();
    isLoading = false;
    // TODO: implement init
    // throw UnimplementedError();
  }

  late Voucher vouchers;

  Future<void> fetchVoucherData() async {
    try {
      final voucherDoc = await FirebaseFirestore.instance
          .collection('vouchers')
          .doc(voucherId)
          .snapshots()
          .listen((query) async {
        vouchers = Voucher.fromFireStore(
            query.data() as Map<String, dynamic>, voucherId);

        notifyListeners();
      });
    } catch (e) {
      print("error fetching voucher: $e");
    }
  }
}
