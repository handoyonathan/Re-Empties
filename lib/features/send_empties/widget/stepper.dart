import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WasteCategoryStepper extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  // final bool isAdmin;

  const WasteCategoryStepper({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
    // this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.network(imagePath, fit: BoxFit.contain),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.appbarTitle,
                ),
                Gap(5.h),
                Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Text(
                        description,
                        style: textTheme.label
                            .copyWith(fontWeight: FontWeight.w300),
                      ),
                    ),
                    const Flexible(
                      flex: 1,
                      child: SizedBox(),
                    )
                  ],
                ),
                Gap(5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: colors.green4),
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: onDecrease,
                        icon: const Icon(Icons.remove),
                        color: colors.bgColor,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                    Gap(10.w),
                    SizedBox(
                      width: 23.h,
                      child: Center(
                        child: Text(
                          '$quantity',
                          style: textTheme.subtitle2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Gap(10.w),
                    Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: colors.green4),
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: onIncrease,
                        icon: const Icon(Icons.add),
                        color: colors.bgColor,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ),
                    // if (isAdmin) ...[
                      Gap(8.w),
                      Text(
                        'Pcs',
                        style: textTheme.voucher.copyWith(color: colors.green4),
                      )
                    // ]
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
