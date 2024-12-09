import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

class CustomPinput extends StatefulWidget {
  final Key formKey;
  final Function(String) onFilled;
  final Function() getErrorText;
  final bool isAdmin;
  // final SmsRetrieverImpl smsRetrieverImpl;
  // final Function() requestOtp;

  const CustomPinput({
    super.key,
    required this.formKey,
    required this.onFilled,
    required this.getErrorText,
    required this.isAdmin,
    // required this.smsRetrieverImpl,
    // required this.requestOtp,
  });

  @override
  State<CustomPinput> createState() => _CustomPinputState();
}

class _CustomPinputState extends State<CustomPinput> {
  late final defaultPinTheme;
  late final focusedPinTheme;
  late final errorPinTheme;
  final TextEditingController _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Setup PIN Themes
    defaultPinTheme = PinTheme(
      width: 45.w,
      height: 45.h,
      decoration: BoxDecoration(
        color: colors.gray2,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.transparent),
      ),
      textStyle: textTheme.dropID,
    );

    focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: colors.green1),
    );

    errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: colors.red1),
    );

    // Listener to convert text to uppercase
  _pinController.addListener(() {
    final text = _pinController.text.toUpperCase();
    if (_pinController.text != text) {
      _pinController.value = _pinController.value.copyWith(
        text: text,
        selection: TextSelection(
          baseOffset: text.length,
          extentOffset: text.length,
        ),
        composing: TextRange.empty,
      );
    }
  });

    if (!widget.isAdmin) {
      // Generate random PIN and set it to the controller
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _generateAndFillPin(); // Pastikan widget dibangun sebelum diisi
      });
    }
  }

  void _generateAndFillPin() {
    final randomPin = _generateRandomPin();
    _pinController.text = randomPin;
    widget.onFilled(randomPin);
  }

  String _generateRandomPin() {
    final random = Random();
    final numbers = List.generate(5, (_) => random.nextInt(10)).join();
    return 'DO$numbers';
  }

  @override
  Widget build(BuildContext context) => Form(
        key: widget.formKey,
        child: Pinput(
          length: 7,
          enabled: widget.isAdmin,
          controller: _pinController,
          onCompleted: (pin) => widget.onFilled(pin),
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          errorPinTheme: errorPinTheme,
          separatorBuilder: (index) => Gap(5.w),
          validator: (_) => widget.getErrorText(),
          errorBuilder: (errorText, pin) => Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Text(
              errorText!,
              style: textTheme.errorText.copyWith(color: colors.red1),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }
}
