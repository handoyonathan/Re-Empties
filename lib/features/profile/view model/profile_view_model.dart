import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileVM extends BaseNotifier {
  ProfileVM(super.ref);

  auth.User? currentUser;
  String userFullName = '';
  String userEmail = '';
  String userPhoneNum = '';

  @override
  Future<void> init() async {
    await fetchUserData();
  }
  

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (ctx.mounted) ctx.goNamed(paths.login);
  }


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
          userEmail = userDoc['userEmail'] ?? '';
          userPhoneNum = userDoc['userPhoneNumber'] ?? '';
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void goToEdit() {
    ctx.pushNamed(paths.editProfile, extra: <String, String?> {
      'fullName': userFullName,
      'email': userEmail,
      'phoneNumber': userPhoneNum,
    }).then((_) => fetchUserData()); // re-fetch datanya
  }
}
