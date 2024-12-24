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
  StreamSubscription? _userPointSubscription;

  @override
  Future<void> init() async {
    isLoading = true;
    await fetchUserData();
    await fetchUserPoint();
    isLoading = false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (ctx.mounted) ctx.goNamed(paths.login);
  }
  
  void goToVoucherPage() {
    ctx.pushNamed(paths.voucher);
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

  int point = 0;
  int totalPoints = 0;

  Future<void> fetchUserPoint() async {
    try {
      _userPointSubscription = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .snapshots()
          .listen((doc) async {
        if (doc.exists && doc.data() != null) {
          // Pastikan rewardPoint ada dan nilainya valid
          point = doc.data()?['rewardPoint'];
          totalPoints = doc.data()?['totalPoints'];
          notifyListeners();
          print('Updated point: $point');
        } else {
          print('User document does not exist or is null.');
        }
      });
    } catch (e) {
      print(
        'Error fetching user data: $e',
      );
    }
  }

  void goToEdit() {
    ctx.pushNamed(paths.editProfile, extra: <String, String?>{
      'fullName': userFullName,
      'email': userEmail,
      'phoneNumber': userPhoneNum,
    }).then((_) => fetchUserData()); // re-fetch datanya
  }

  @override
  void dispose() {
    _userPointSubscription?.cancel(); // Batalkan langganan point user
    super.dispose();
  }
}
