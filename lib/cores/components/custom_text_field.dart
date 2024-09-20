import 'package:flutter/material.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final Widget? prefixIcon; // icon depan
  final Widget? suffixIcon; // icon di belakang
  final Function()? onSuffixPressed;
  final TextEditingController controller;
  final bool isPassword;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final void Function(String?)? onValidate;
  final Function(String)? onSubmit;
  final Function(String)? onChanged;
  final bool hasError;
  final EdgeInsets? customPadding;
  final Color? filledColor;
  final double? borderRadius;
  final double? height;
  final TextInputAction? inputAction;
  final TextInputType? keyboardType;
  final bool isMultiline;
  final Function(bool)? onOutOfFocus;
  final bool autofocus;

  const CustomTextField({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixPressed,
    required this.controller,
    this.isPassword = false,
    this.focusNode,
    this.validator,
    this.onValidate,
    required this.onSubmit,
    this.onChanged,
    this.hasError = false,
    this.customPadding,
    this.filledColor,
    this.borderRadius,
    this.height,
    this.inputAction,
    this.keyboardType,
    required this.isMultiline,
    this.onOutOfFocus,
    this.autofocus =
        false, // bikin true, kalo misalkan buat password biar jd bintang bintang
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool
      isObscured; // buat bikin si password jd ********************************

  @override
  void initState() {
    isObscured = widget.isPassword;
    super.initState();
  }

  // mastiin si Custom Text Fieldnya ada warna nya atau engga
  bool get filledColor => widget.filledColor != null;

  InputBorder getBorder(Color color) => OutlineInputBorder(
        borderSide: BorderSide(
            color: filledColor
                ? Colors.transparent
                : widget.hasError
                    ? colors.red1
                    : color,
            width: 2.0),
        borderRadius: BorderRadius.circular(15.0),
      );

  eyeIconPressed() {
    // buat control si icon eye yang ada di password
    setState(() {
      isObscured = !isObscured;
    });
  }

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
          color: colors.gray2, borderRadius: BorderRadius.circular(15.0)),
      height: widget.height,
      child: Focus(
          onFocusChange: widget.onOutOfFocus,
          child: TextFormField(
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            textInputAction: widget.inputAction,
            keyboardType: widget.keyboardType,
            controller: widget.controller,
            onChanged: widget.onChanged,
            obscureText: isObscured,
            maxLines: widget.isMultiline ? 4 : 1,
            decoration: InputDecoration(
              contentPadding: widget.customPadding ??
                  EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: colors.green1,
                fontSize: 15.0,
              ),
              filled: filledColor,
              fillColor: widget.filledColor,
              focusedBorder: getBorder(
                colors.green1,
              ),
              border: getBorder(colors.gray2),
              errorBorder: getBorder(colors.red1),
              focusedErrorBorder: getBorder(colors.red2),
              errorStyle: TextStyle(
                fontSize: 10.0,
                color: colors.red1,
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                      onTap: eyeIconPressed,
                      child: Icon(
                          !isObscured
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: colors.blueText),
                    )
                  : null,
            ),
            style: textTheme.textFieldLabel,
            validator: (value) {
              String? errorMessage = widget.validator?.call(value ?? '');
              widget.onValidate?.call(errorMessage);
              return errorMessage;
            },
            onFieldSubmitted: widget.onSubmit,
          )));
}
