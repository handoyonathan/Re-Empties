import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/components/tap_detector.dart';

class ReedemPointsCard extends StatelessWidget {
  final String points; // Add a parameter for the points value

  const ReedemPointsCard({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: colors.green5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 21.h),
            child: Row(
              children: [
                ImageAsset(
                  imagePath: images.pointImg,
                  height: 52.h,
                  width: 38.w,
                  fit: BoxFit.cover,
                ),
                Gap(10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your points',
                      style: textTheme.pointLabel
                          .copyWith(height: 1.0, color: colors.green1),
                    ),
                    Text(
                      points, // Use the points parameter
                      style: textTheme.point.copyWith(height: 1.2),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          Positioned(
            right: 0, // Position the image at the right edge of the card
            top: 0, // Align with the top
            bottom: 0, // Align with the bottom
            child: ImageAsset(
              imagePath: images.reedemBg,
              width: 150.w,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
