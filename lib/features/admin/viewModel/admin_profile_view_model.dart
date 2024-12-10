import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminProfileVM extends BaseNotifier {
  AdminProfileVM(super.ref);

  @override
  FutureOr<void> init() {

  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    ctx.goNamed(paths.login);
  }
  
}