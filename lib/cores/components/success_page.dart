import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/router/router_constant.dart';

class SuccessPage extends StatefulWidget {
  final bool isSend;
  final int? point;
  final bool isAdmin;

  const SuccessPage({
    super.key,
    required this.isSend,
    this.point,
    required this.isAdmin,
  });

  @override
  SuccessPageState createState() => SuccessPageState();
}

class SuccessPageState extends State<SuccessPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      !widget.isAdmin
          ? widget.isSend
              ? ctx.pushReplacementNamed(paths.home)
              : ctx.pop('refresh')
          : ctx.pushReplacementNamed(paths.adminView);
    });
  }

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
                imagePath: widget.isAdmin || widget.isSend
                    ? images.successCircle
                    : images.successStar,
                width: 305.w,
                height: 305.h,
              ),
              Gap(50.h),
              Text(
                widget.isAdmin
                    ? 'Order has been verified'
                    : widget.isSend
                        ? 'Send Waste Successful !'
                        : 'Drop Off Successful !',
                style: textTheme.successTitle.copyWith(
                  decoration: TextDecoration.none,
                ),
              ),
              Gap(5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Text(
                  widget.isAdmin
                      ? 'Thank you for confirming the recycling request and supporting our mission to reduce skincare packaging waste.'
                      : widget.isSend
                          ? "We appreciate your contribution to recycling skincare packaging. Together, we're making a cleaner, greener future possible."
                          : "We're excited to help you recycle your skincare packaging waste. Let's make a positive impact together!",
                  style: textTheme.label.copyWith(
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (!widget.isAdmin && widget.point != null) ...[
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
                    '+${widget.point} points',
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
