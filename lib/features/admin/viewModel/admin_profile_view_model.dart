import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminProfileVM extends BaseNotifier {
  AdminProfileVM(super.ref);
  auth.User? currentAdmin;
  String adminName = '';
  String addressStation = '';  

  @override
  FutureOr<void> init() async {
    isLoading = true;
    await fetchAdminData();
    isLoading = false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await prefs.setBool('isAdminLoggedIn', false);

    ctx.goNamed(paths.login);
  }

  Future<void> fetchAdminData() async {
    try {
      currentAdmin = auth.FirebaseAuth.instance.currentUser;
      if (currentAdmin != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('admin')
            .doc(currentAdmin!.uid)
            .get();

        if (userDoc.exists) {
          adminName = userDoc['stationName'];
          addressStation = userDoc['addressStation'];
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}
