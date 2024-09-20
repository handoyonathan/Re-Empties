import 'package:flutter/material.dart';

class _RouterPaths {
  final String home = 'home';
  final String auth = 'auth';
  final String article = 'article';
}

final paths = _RouterPaths();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
BuildContext get ctx => navigatorKey.currentContext!;
