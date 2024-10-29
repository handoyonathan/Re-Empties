import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

class SuccessPage extends StatelessWidget {
  final bool isDrop;
  final String points;

  const SuccessPage({
    super.key,
    required this.isDrop,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ImageAsset(
            imagePath: images.successBg,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Center(
              child: Column(
                children: [
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  ImageAsset(
                    imagePath: isDrop ? images.successDrop : images.successSend,
                    width: isDrop ? 275.w : 245.w,
                    height: isDrop ? 275.h : 245.h,
                  ),
                  Gap(50.h),
                  Text(
                    isDrop ? 'Drop Off Successful !' : 'Payment Successful !',
                    style: textTheme.successTitle,
                  ),
                  Gap(10.h),
                  Text(
                    isDrop
                        ? "We're excited to help you recycle your skincare packaging waste. Let's make a positive impact together!"
                        : "We appreciate your contribution to recycling skincare packaging. Together, we're making a cleaner, greener future possible.",
                    style: textTheme.label,
                    textAlign: TextAlign.center,
                  ),
                  Gap(70.h),
                  Text(
                    'You will get',
                    style: textTheme.successPointLabel,
                  ),
                  Gap(10.h),
                  IntrinsicWidth(
                    child: Container(
                      constraints:
                          BoxConstraints(minWidth: 125.w),
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: colors.red5,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5.w),
                        child: Center(
                          child: Text(
                            '+$points points',
                            style: textTheme.formName,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
