import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseNotifier extends ChangeNotifier {
  bool _isLoading = false;
  bool _isDisposed = false;
  bool _isInitializeDone = false;

  final AutoDisposeChangeNotifierProviderRef<Object?> ref;

  BaseNotifier(this.ref) {
    _init();
  }

  FutureOr<void> init();

  void _init() async {
    isLoading = true;
    await init();
    _isInitializeDone = true;
    isLoading = false;
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  // Getters
  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitializeDone;

  // Setters
  set isLoading(bool value) {
    _isLoading = value;
    scheduleMicrotask(() {
      if (!_isDisposed) notifyListeners();
    });
  }
}
