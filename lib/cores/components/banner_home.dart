import 'package:flutter/material.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/components/tap_detector.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BannerHome extends StatelessWidget {
  final int level; // Level from 1 to 5

  const BannerHome({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    String imagePath;
    String greetingText;
    String progressText;

    switch (level) {
      case 1:
        imagePath = images.level1;
        greetingText = "Eco Explorer";
        progressText = "to Green Guardian";
        break;
      case 2:
        imagePath = images.level2;
        greetingText = "Green Guardian";
        progressText = "to Recycle Ranger";
        break;
      case 3:
        imagePath = images.level3;
        greetingText = "Recycle Ranger";
        progressText = "to Planet Protector";
        break;
      case 4:
        imagePath = images.level4;
        greetingText = "Planet Protector";
        progressText = "to Sustainability Superstar";
        break;
      case 5:
        imagePath = images.level5;
        greetingText = "Sustainability Superstar";
        progressText = ""; // No percentage or progress text for level 5
        break;
      default:
        imagePath = images.level1;
        greetingText = "Eco Explorer";
        progressText = "to Green Guardian";
    }

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.r),
          bottomRight: Radius.circular(15.r),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.r),
          bottomRight: Radius.circular(15.r),
        ),
        child: Stack(
          children: [
            // Background Color

            // Background Image
            Positioned.fill(
              child: ImageAsset(
                imagePath: imagePath, // Your custom image widget
                fit: BoxFit.cover,
              ),
            ),
            // Foreground Content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 52.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (level == 5)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,",
                          style: textTheme.successPointLabel
                              .copyWith(color: colors.green2),
                        ),
                        Text(
                          greetingText,
                          style: textTheme.title.copyWith(
                              fontWeight: FontWeight.w900,
                              color: colors.green2),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Text(
                          "Hello,",
                          style: textTheme.successPointLabel
                              .copyWith(color: colors.green2),
                        ),
                        Gap(2.w),
                        Text(
                          greetingText,
                          style: textTheme.title.copyWith(
                              fontWeight: FontWeight.w900,
                              color: colors.green2),
                        ),
                      ],
                    ),
                  if (level != 5) ...[
                    Gap(2.h),
                    Row(
                      children: [
                        Text(
                          "50%",
                          style: textTheme.badgeLevel,
                        ),
                        Gap(3.w),
                        Text(
                          progressText,
                          style: textTheme.badgesText,
                        ),
                      ],
                    ),
                    Transform.translate(
                      offset: Offset(-10.w, 0),
                      child: LinearPercentIndicator(
                        width: 265.w,
                        lineHeight: 20.0,
                        percent: 0.5,
                        barRadius: Radius.circular(15),
                        progressColor: colors.yellow1,
                        backgroundColor: colors.gray1,
                      ),
                    ),
                  ],
                  Gap(5.h),
                  if (level == 5)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "You have reached the highest level, keep recycling to get",
                          style: textTheme.badgesLabel.copyWith(height: 0.5),
                        ),
                        Gap(3.h),
                        Text(
                          "more bonus points!",
                          style: textTheme.badgesLabel
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Gap(35.h),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Text(
                          "Recycle empties and you will get a reward of",
                          style: textTheme.badgesLabel.copyWith(height: 0.5),
                        ),
                        Gap(2.w),
                        Text(
                          "20.000 points",
                          style: textTheme.badgesLabel
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
