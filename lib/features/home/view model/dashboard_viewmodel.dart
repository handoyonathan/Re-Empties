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
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!isLoggedIn) {
      context.go('/login');
    }
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    ctx.pushReplacement('/login');
  }

  void goToIntroPage({bool? isSend}) {
    ctx.pushNamed(paths.intro, extra: isSend);
  }

  @override
  FutureOr<void> init() {
    checkLoginStatus(ctx);
  }
}
