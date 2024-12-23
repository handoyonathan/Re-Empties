import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/components/tap_detector.dart';

class CustomSheetVoucher extends StatelessWidget {
  final String title;
  final String description;
  final String points;
  final String category;
  final VoidCallback onTap;

  const CustomSheetVoucher({
    super.key,
    required this.title,
    required this.description,
    required this.points,
    required this.category,
    required this.onTap,
  });

  String getImagePath() {
    switch (category.toLowerCase()) {
      case 'food':
        return images.categoryFoodBev;
      case 'shopping':
        return images.categoryShopping;
      case 'games':
        return images.categoryGames;
      default:
        return images.categoryDefault;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(40), // Top-left corner rounded
        topRight: Radius.circular(40), // Top-right corner rounded
      ),
      child: Container(
        color: colors.background, // Set the background color of the sheet
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Adjust the height to fit the content
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Short horizontal line
              Container(
                width: 34.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: colors.black, // Adjust color as desired
                  borderRadius: BorderRadius.circular(
                      4), // Adjust the radius to control the roundness
                ),
              ),
              Gap(16.h),
              // Image
              Image.asset(
                getImagePath(),
                height: 84.0,
                width: 84.0,
                fit: BoxFit.cover,
              ),
              Gap(8.h),
              // Title Text
              Text(
                title,
                style: textTheme.appbarTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              Gap(8.h),
              // Description Text
              Text(
                description,
                style: textTheme.badgesText,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              Gap(32.h),
              // Button with padding, no shadow, rounded corners, and custom color

              AppMainButton(
                  state: ButtonState.primary,
                  text: 'Use $points points',
                  onPressed: onTap
                  // context.pushNamed(
                  //   'voucherDetail', // Ensure this matches your GoRouter path name
                  // );

                  ),

              Gap(16.h),
            ],
          ),
        ),
      ),
    );
  }
}
