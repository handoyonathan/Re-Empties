import 'package:flutter/material.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BannerHome extends StatelessWidget {
  final int level; // Level from 1 to 5
  final bool isProfilePage;
  final int totalPoints; // Total points user has (for level calculation)
  final int availablePoints; // Available points user can use (for redemption)

  const BannerHome(
      {super.key,
      required this.level,
      required this.isProfilePage,
      required this.totalPoints,
      required this.availablePoints});

  int calculateLevel(int points) {
    if (points >= 7500) return 5;
    if (points >= 3500) return 4;
    if (points >= 1500) return 3;
    if (points >= 500) return 2;
    return 1;
  }

   // Define points needed to level up
    static const Map<int, int> levelPoints = {
      1: 500, // Level 1 to Level 2
      2: 1500, // Level 2 to Level 3
      3: 3500, // Level 3 to Level 4
      4: 7500, // Level 4 to Level 5
    };

  @override
  Widget build(BuildContext context) {
    String imagePath;
    String greetingText;
    String progressText;
    double progressPercent = 0.0;

    // int pointsToNextLevel = 0;
    // int currentLevelPoints = 0;

    int level = calculateLevel(totalPoints);

    // Calculate progress percent and next level points
    switch (level) {
      case 1:
        imagePath = images.level1;
        greetingText = "Eco Explorer";
        progressText = "to Green Guardian";
        progressPercent = totalPoints / 500;
        break;
      case 2:
        imagePath = images.level2;
        greetingText = "Green Guardian";
        progressText = "to Recycle Ranger";
        progressPercent = (totalPoints - 500) / 1000;
        break;
      case 3:
        imagePath = images.level3;
        greetingText = "Recycle Ranger";
        progressText = "to Planet Protector";
        progressPercent = (totalPoints  - 1500) / 2000;
        break;
      case 4:
        imagePath = images.level4;
        greetingText = "Planet Protector";
        progressText = "to Sustainability Superstar";
        progressPercent = (totalPoints - 3500) / 4000;
        break;
      case 5:
        imagePath = images.level5;
        greetingText = "Sustainability Superstar";
        progressText = "";
        progressPercent = 1.0;
        break;
      default:
        imagePath = images.level1;
        greetingText = "Eco Explorer";
        progressText = "to Green Guardian";
        progressPercent = totalPoints / 500;
    }


    String percentageText = '${(progressPercent * 100).clamp(0, 100).toStringAsFixed(0)}%';

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: isProfilePage
            ? BorderRadius.circular(15.r)
            : BorderRadius.only(
                bottomLeft: Radius.circular(15.r),
                bottomRight: Radius.circular(15.r),
              ),
      ),
      child: Stack(
        children: [
          // Background Image
          SizedBox.square(
            child: isProfilePage
                ? ImageAsset(
                    imagePath: images.pointsProfile,
                    fit: BoxFit.cover,
                  )
                : ImageAsset(
                    imagePath: imagePath, // Your custom image widget
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 210.h,
                  ),
          ),
          // Foreground Content
          Padding(
            padding: isProfilePage
                ? const EdgeInsets.all(8)
                : EdgeInsets.symmetric(horizontal: 12.w, vertical: 56.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (level == 5)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isProfilePage
                          ? Text(
                              greetingText,
                              style: textTheme.title.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: colors.green2),
                            )
                          : Text(
                              "Hello,",
                              style: textTheme.successPointLabel
                                  .copyWith(color: colors.green2),
                            ),
                      Gap(2.w),
                      if (!isProfilePage)
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
                      isProfilePage
                          ? Text(
                              greetingText,
                              style: textTheme.title.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: colors.green2),
                            )
                          : Text(
                              "Hello,",
                              style: textTheme.successPointLabel
                                  .copyWith(color: colors.green2),
                            ),
                      Gap(2.w),
                      isProfilePage
                          ? Gap(1.w)
                          : Text(
                              greetingText,
                              style: textTheme.title.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: colors.green2),
                            ),
                    ],
                  ),
                if (level != 5) ...[
                  Gap(5.h),
                  Row(
                    children: [
                      Text(
                        percentageText,
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
                      width: MediaQuery.of(context).size.width * 0.7,
                      lineHeight: 14.h,
                      percent: progressPercent.clamp(0, 1),
                      barRadius: Radius.circular(15.r),
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
                      Gap(32.h),
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
                        "points",
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
    );
  }
}
