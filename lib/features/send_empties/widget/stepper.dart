import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WasteCategoryStepper extends StatefulWidget {
  final String title;
  final String description;
  final String imageAssetPath;

  const WasteCategoryStepper({
    super.key,
    required this.title,
    required this.description,
    required this.imageAssetPath,
  });

  @override
  WasteCategoryStepperState createState() => WasteCategoryStepperState();
}

class WasteCategoryStepperState extends State<WasteCategoryStepper> {
  int quantity = 1;

  void _increaseQuantity() {
    setState(() {
      quantity += 1;
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity -= 1;
      }
    });
  }

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
            child: Image.asset(widget.imageAssetPath, fit: BoxFit.contain),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: textTheme.appbarTitle,
                ),
                Gap(5.h),
                Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Text(
                        widget.description,
                        style: textTheme.label.copyWith(fontWeight: FontWeight.w300),
                      ),
                    ),
                    const Flexible(flex: 1,child: SizedBox(),)
                  ],
                ),
                Gap(5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end, // Menambahkan ini
                  children: [
                    Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: colors.green4),
                      alignment: Alignment.center,
                      child: FittedBox(
                        child: IconButton(
                          onPressed: _decreaseQuantity,
                          icon: const Icon(
                            Icons.remove,
                          ),
                          color: colors.bgColor,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                    ),
                    Gap(10.w),
                    Text(
                      '$quantity',
                      style: textTheme.subtitle2,
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
                        onPressed: _increaseQuantity,
                        icon: const Icon(Icons.add),
                        color: colors.bgColor,
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
