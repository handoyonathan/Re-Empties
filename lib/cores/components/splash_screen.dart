import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isUserLoggedIn = pref.getBool('isUserLoggedIn') ?? false;
    bool isAdminLoggedIn = pref.getBool('isAdminLoggedIn') ?? false;

    // Splash screen loading time
    await Future.delayed(const Duration(seconds: 2));

    if (isUserLoggedIn) {
      if (ctx.mounted) ctx.goNamed(paths.home);
    }
    else if (isAdminLoggedIn){
      if (ctx.mounted) ctx.goNamed(paths.adminView);
    }
    else {
      if (ctx.mounted) ctx.goNamed(paths.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash_image.png',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
