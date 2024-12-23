// voucherViewModel.dart
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:re_empties/features/voucher/model/voucher_model.dart';

class VoucherViewModel extends BaseNotifier {
  VoucherViewModel(super.ref);

  @override
  FutureOr<void> init() async {
    isLoading = true;
    await fetchVoucherData();
    isLoading = false;
    // TODO: implement init
    // throw UnimplementedError();
  }

  List<Voucher> vouchers = [];

  Future<void> fetchVoucherData() async {
    try {
      final voucherDoc = await FirebaseFirestore.instance
          .collection('vouchers')
          .snapshots()
          .listen((query) async {
        for (var doc in query.docs) {
          // print("Document Data: ${doc.data()}");
          Voucher temp =
              Voucher.fromFireStore(doc.data() as Map<String, dynamic>, doc.id);

          print(temp.voucherID.toString());
          vouchers.add(temp);
        }
        notifyListeners();
      });
    } catch (e) {
      print("error fetching voucher: $e");
    }
  }

  void goToDetailVoucher(int index) async {
    ctx.pop();
    ctx.pushNamed(paths.voucherDetail, extra: vouchers[index].voucherID);
  }
}
