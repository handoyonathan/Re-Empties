import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/string_extension.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/text_input_model.dart';
import 'custom_text_field.dart';

class FormTextField extends StatefulWidget {
  final TextInputModel inputModel;
  final String hint;
  final bool isPassword;
  final Function(String)? onSubmit;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Function()? onSuffixPressed;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool isMultiline;
  final Function()? setPhoneDropdownBorderError;
  final EdgeInsets? contentPadding;
  final Function(bool)? onOutOfFocus;

  const FormTextField({
    super.key,
    required this.inputModel,
    required this.hint,
    this.onSubmit,
    this.isPassword = false,
    this.prefixWidget,
    this.suffixWidget,
    this.onSuffixPressed,
    this.onChanged,
    this.keyboardType,
    this.isMultiline = false,
    this.setPhoneDropdownBorderError,
    this.contentPadding,
    this.onOutOfFocus,
  });

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  String? errorMessage;

  bool get hasError => errorMessage.isNotNullOrEmpty;
  TextInputModel get model => widget.inputModel;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CustomTextField(
                hint: widget.hint,
                controller: model.controller,
                isPassword: widget.isPassword,
                keyboardType: widget.keyboardType,
                hasError: hasError,
                contentPadding: widget.contentPadding,
                onOutOfFocus: widget.onOutOfFocus,
                validator: (value) {
                  if (value!.isEmpty) {
                    return null;
                  }
                  return model.validator?.call(value);
                },
                onValidate: (String? error) {
                  setState(() {
                    errorMessage = error;
                  });
                },
                onChanged: (value) {
                  if (errorMessage != null) {
                    setState(() {
                      errorMessage = null;
                      if (widget.setPhoneDropdownBorderError != null) {
                        widget.setPhoneDropdownBorderError!();
                      }
                    });
                  }
                  widget.onChanged?.call(value);
                },
                onSubmit: widget.onSubmit,
                prefixIcon: widget.prefixWidget,
                suffixIcon: widget.suffixWidget,
                // prefixWidget: widget.prefixWidget,
                // suffixWidget: widget.suffixWidget,
                onSuffixPressed: widget.onSuffixPressed,
                inputAction: TextInputAction.next,
                isMultiline: widget.isMultiline,
              ),
            ],
          ),
          if (hasError) ...[
            Gap(8.h),
            Text(
              errorMessage ?? '',
              style: textTheme.errorText.copyWith(color: colors.red1),
            ),
          ],
        ],
      );
}
