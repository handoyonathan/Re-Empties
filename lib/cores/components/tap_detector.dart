import 'dart:async';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class TapDetector extends StatelessWidget with DebounceMixin {
  final Function()? onTap;
  final Widget child;
  final int? debounceMs;

  TapDetector({
    super.key,
    required this.onTap,
    required this.child,
    this.debounceMs,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () {
        debouncing(
          fn: () => onTap?.call(),
          milliseconds: debounceMs ?? 150,
        );
      },
      child: child,
    );
}


mixin DebounceMixin {
  Timer? _debounceTimer;

  void debouncing({required Function() fn, int milliseconds = 150}) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: milliseconds), fn);
  }
}