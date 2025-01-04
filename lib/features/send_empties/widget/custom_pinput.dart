import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:re_empties/cores/components/string_extension.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/features/send_empties/widget/bottom_sheet.dart';

class CustomPinput extends StatefulWidget {
  final Key formKey;
  final Function(String) onFilled;
  final Function() getErrorText;
  final bool isAdmin;
  final String value;
  // final SmsRetrieverImpl smsRetrieverImpl;
  // final Function() requestOtp;

  const CustomPinput({
    super.key,
    required this.formKey,
    required this.onFilled,
    required this.getErrorText,
    required this.isAdmin,
    this.value = '',
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
  late final TextEditingController _pinController;

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

    if (widget.value.isNullOrEmpty) {
      // Jika nilai kosong, inisialisasi controller dengan string kosong
      _pinController = TextEditingController();
    } else {
      _pinController = TextEditingController(text: widget.value);
    }

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

    // if (!widget.isAdmin) {
    //   // Generate random PIN and set it to the controller
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     _generateAndFillPin(); // Pastikan widget dibangun sebelum diisi
    //   });
    // }
  }

  // void _generateAndFillPin() {
  //   final randomPin = _generateRandomPin();
  //   _pinController.text = randomPin;
  //   widget.onFilled(randomPin);
  // }

  // String _generateRandomPin() {
  //   final random = Random();
  //   final numbers = List.generate(5, (_) => random.nextInt(10)).join();
  //   return 'DO$numbers';
  // }

  @override
  Widget build(BuildContext context) => Form(
        key: widget.formKey,
        child: Pinput(
          keyboardType: TextInputType.text,
          length: 7,
          enabled: widget.isAdmin,
          controller: _pinController,
          onCompleted: (pin) {
            if (pin.isEmpty || pin.length < 7) {
              widget.onFilled(pin); // Validasi akan dilakukan di ViewModel
            } else {
              widget.onFilled(pin);
            }
          },
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          errorPinTheme: errorPinTheme,
          separatorBuilder: (index) => Gap(5.w),
          validator: (_) => widget.getErrorText(),
          errorBuilder: (errorText, pin) => Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Text(
              errorText!,
              style: textTheme.errorText.copyWith(fontSize: 12.sp),
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
