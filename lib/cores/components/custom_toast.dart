import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

class CustomToast extends StatelessWidget {
  final String text;
  final bool isError;
  const CustomToast({
    super.key,
    this.text = 'text here',
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(16.w),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 11.h,
          ),
          decoration: BoxDecoration(
            color: isError ? colors.red1 : colors.green2,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: textTheme.pointLabel.copyWith(color: colors.background),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      );
}
