import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/components/tap_detector.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/constant/colors.dart';

// Enum for the card states
enum SendDropState { send, drop }

class HomeSendDropCard extends StatelessWidget {
  final SendDropState state; // Accept state as a parameter
  final VoidCallback onTap; // Accept onTap function as a parameter

  const HomeSendDropCard({
    super.key,
    required this.state,
    required this.onTap, // Pass the onTap callback
  });

  @override
  Widget build(BuildContext context) {
    final String titleText = state == SendDropState.send ? 'Send' : 'Drop';
    final String imagePath = state == SendDropState.send
        ? images.sendWaste // Image for 'send'
        : images.dropWaste; // Image for 'drop'

    return TapDetector(
      // Wrap the entire card with TapDetector
      onTap: onTap, // Trigger the onTap action when tapped
      child: Card(
        color: colors.green2,
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
          child: Column(
            children: [
              // Circle with image inside
              Stack(
                alignment:
                    Alignment.center, // Align image in the center of the circle
                children: [
                  // Circle with background color
                  CircleAvatar(
                    backgroundColor: colors.green4, // Your desired green color
                    radius: 40.r, // Adjust the size of the circle
                  ),
                  // Image on top of the circle
                  ImageAsset(
                    imagePath: imagePath, // Your image path here
                    height: 60.h, // Adjust the image height as needed
                    width: 60.w, // Adjust the image width as needed
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              const Gap(2), // Space between the image and the first text
              Text(
                titleText,
                style: textTheme.title.copyWith(color: colors.bgColor),
              ),
              // Text "Your waste"
              Text(
                'Your waste',
                style: textTheme.featureLabel2.copyWith(height: 0.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
