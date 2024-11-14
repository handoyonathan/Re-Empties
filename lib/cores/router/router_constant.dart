import 'package:flutter/material.dart';

class _RouterPaths {
  final String home = 'home';
  final String auth = 'auth';
  final String article = 'article';
  final String login = 'login';
  final String register = 'register';
  final String test = 'test';
  final String success = 'success';
  final String splash = 'splash';
}

final paths = _RouterPaths();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
BuildContext get ctx => navigatorKey.currentContext!;
