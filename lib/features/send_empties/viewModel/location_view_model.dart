import 'dart:async';

import 'package:flutter/material.dart';
import 'package:re_empties/cores/template/notifer.dart';


class LocationVM extends BaseNotifier {
  final TextEditingController userController = TextEditingController();
  final FocusNode userFocusNode = FocusNode();
  final TextEditingController stationController = TextEditingController();
  final FocusNode stationFocusNode = FocusNode();

  LocationVM(
    super.ref,);

  @override
  FutureOr<void> init() {}
}
