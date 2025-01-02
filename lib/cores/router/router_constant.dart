import 'package:flutter/material.dart';

class _RouterPaths {
  final String home = 'home';
  final String auth = 'auth';
  final String article = 'article';
  final String login = 'login';
  final String register = 'register';
  final String success = 'success';
  final String adminView = 'adminView';
  final String adminProfile = 'adminProfile';
  final String splash = 'splash';
  final String editProfile = 'editProfile';
  final String profile = 'profile';
  final String location = 'location';
  final String intro = 'intro';
  final String sendForm = 'sendForm';
  final String dropPointDetail = 'dropPointDetail';
  final String fillDropID = 'fillDropID';
  final String transactionDetail = 'transactionDetail';
  final String transactionHistory = 'transactionHistory';
  final String transactionHistoryDetail = 'transactionHistoryDetail';
  final String countDown = 'countDown';
  final String voucherDetail = 'voucherDetail';
  final String voucher = 'voucher';
}

final paths = _RouterPaths();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
BuildContext get ctx => navigatorKey.currentContext!;
