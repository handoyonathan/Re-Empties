import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/components/tap_detector.dart';

class HomePointsCard extends StatelessWidget {
  final VoidCallback onTap; // Accept onTap function as a parameter

  const HomePointsCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TapDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        color: colors.red6,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r))),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              children: [
                //image
                ImageAsset(
                  imagePath: images.pointImg,
                  height: 45.h,
                  width: 35.w,
                  fit: BoxFit.cover,
                ),

                Gap(10.w),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your points', style: textTheme.pointLabel),
                    Text(
                      '12,000', // Points value
                      style: textTheme.myPoint,
                    ),
                  ],
                ),

                // Spacer to push the chevron icon to the right
                const Spacer(),

                // Circle with chevron icon
                CircleAvatar(
                  backgroundColor: colors.textButton, // Background color
                  radius: 14.r, // Adjust size as needed
                  child: Icon(
                    Icons.chevron_right, // Chevron pointing right
                    size: 24.sp, // Icon size
                    color: colors.bgColor, // Icon color
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
