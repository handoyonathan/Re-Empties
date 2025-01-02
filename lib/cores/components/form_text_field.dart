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
  final bool showPhoneField; // Boolean to determine if the phone field should be shown

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
    this.showPhoneField = false,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.showPhoneField)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: colors.gray2,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: colors.blueText,
                            size: 20.sp,
                          ),
                          Gap(8.w),
                          Text(
                            "+62",
                            style: textTheme.formName,
                          ),
                        ],
                      ),
                    ),
                  if (widget.showPhoneField) Gap(8.w),
                  Expanded(
                    child: CustomTextField(
                      hint: widget.hint,
                      controller: model.controller,
                      isPassword: widget.isPassword,
                      keyboardType: widget.keyboardType,
                      hasError: hasError,
                      contentPadding: widget.contentPadding,
                      onOutOfFocus: widget.onOutOfFocus,
                      validator: (value) {
                        return model.validator?.call(value!);
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
                          });
                        }
                        widget.onChanged?.call(value);
                      },
                      onSubmit: widget.onSubmit,
                      prefixIcon: widget.showPhoneField ? null : widget.prefixWidget,
                      suffixIcon: widget.suffixWidget,
                      onSuffixPressed: widget.onSuffixPressed,
                      inputAction: TextInputAction.next,
                      isMultiline: widget.isMultiline,
                    ),
                  ),
                ],
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
