import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

class SuccessPage extends StatelessWidget {
  final bool isPayment;
  final int? point;
  final bool isAdmin;

  const SuccessPage({
    super.key,
    this.isPayment = false,
    this.point,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: ImageAsset(imagePath: images.successBg),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            children: [
              Gap(100.h),
              ImageAsset(
                imagePath: isAdmin || isPayment
                    ? images.successCircle
                    : images.successStar,
                width: 305.w,
                height: 305.h,
              ),
              Gap(50.h),
              Text(
                isPayment
                    ? 'Payment Successful !'
                    : isAdmin
                        ? 'Order has been verified'
                        : 'Drop Off Successful !',
                style: textTheme.successTitle.copyWith(
                  decoration: TextDecoration.none,
                ),
              ),
              Gap(5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Text(
                  isPayment
                      ? "We appreciate your contribution to recycling skincare packaging. Together, we're making a cleaner, greener future possible."
                      : isAdmin
                          ? 'Thank you for confirming the recycling request and supporting our mission to reduce skincare packaging waste.'
                          : "We're excited to help you recycle your skincare packaging waste. Let's make a positive impact together!",
                  style: textTheme.label.copyWith(
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (!isAdmin && point != null) ...[
                Gap(50.h),
                Text(
                  'You will get',
                  style: textTheme.successPointLabel.copyWith(
                    decoration: TextDecoration.none,
                  ),
                ),
                Gap(5.h),
                Container(
                  width: 120.w,
                  height: 25.h,
                  decoration: BoxDecoration(
                    color: colors.red5,
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                    child: Text(
                      '+$point points',
                      style: textTheme.formName.copyWith(
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.center,
                  ),
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }
}
