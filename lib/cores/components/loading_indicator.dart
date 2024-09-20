import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:re_empties/cores/constant/colors.dart';

class LoadingIndicator extends StatelessWidget {
  final bool showBackdrop;
  final double? width;
  final double? height;
  final double? indicatorSize;

  const LoadingIndicator({
    super.key,
    this.showBackdrop = false,
    this.width,
    this.height,
    this.indicatorSize,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        color: showBackdrop ? colors.gray1 : null,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: showBackdrop ? Colors.white : null,
            ),
            padding: const EdgeInsets.all(16),
            width: indicatorSize,
            height: indicatorSize,
            child: CircularProgressIndicator(
              color: colors.green1,
              strokeWidth: indicatorSize != null ? (indicatorSize! / 8) : 4.w,
            ),
          ),
        ),
      );
}
