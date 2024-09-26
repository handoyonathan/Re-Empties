import 'package:flutter/material.dart';
import 'package:re_empties/cores/template/notifer.dart';

abstract class BaseFormNotifier<T extends Object> extends BaseNotifier
    implements FormInterface<T> {
  final _formKey = GlobalKey<FormState>();

  BaseFormNotifier(super.ref);

  GlobalKey<FormState> get formKey => _formKey;

  bool validate() => formKey.currentState!.validate();
}

abstract class FormInterface<T> {
  late T form;
}
