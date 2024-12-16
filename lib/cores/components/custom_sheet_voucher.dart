import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/components/tap_detector.dart';

class CustomSheetVoucher extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String points;

  const CustomSheetVoucher({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.points,
  });

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
                imagePath,
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
              SizedBox(
                width:
                    double.infinity, // Make the button take all available space
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Use $points points',
                      style:
                          textTheme.formName.copyWith(color: colors.bgColor)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.green2, // Set button color
                    foregroundColor:
                        Colors.white, // Set button text color to white
                    elevation: 0, // Remove shadow
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Set rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0), // Add padding to button text
                  ),
                ),
              ),
              Gap(16.h),
            ],
          ),
        ),
      ),
    );
  }
}
