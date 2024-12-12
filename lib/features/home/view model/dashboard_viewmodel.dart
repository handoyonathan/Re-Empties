import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardVM extends BaseNotifier {
  DashboardVM(super.ref);

  Future<void> checkLoginStatus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    bool isUserLoggedIn = prefs.getBool('isUserLoggedIn') ?? false;

    if (!isUserLoggedIn) {
      context.go('/login');
    }
  }
  
  void goToIntroPage({bool? isSend}) {
    ctx.pushNamed(paths.intro, extra: isSend);
  }

  @override
  FutureOr<void> init() {
    checkLoginStatus(ctx);
  }
}
