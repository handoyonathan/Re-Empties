import 'dart:async';

import 'package:flutter/material.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/notifer.dart';

class HomeVM extends BaseNotifier {
  int selectedIndex = 0;
  late TabController controller;

  HomeVM(super.ref);

  void setController({required int length, required TickerProvider vsync}) {
    controller = TabController(length: length, vsync: vsync);
  }

  void selectIndex(int index) {
    if (selectedIndex == index) return;
    selectedIndex = index;
    FocusScope.of(ctx).unfocus();
    controller.animateTo(index);
    notifyListeners();
  }

  @override
  FutureOr<void> init() {
  }
  
}