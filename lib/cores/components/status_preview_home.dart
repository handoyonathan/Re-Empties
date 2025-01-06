import 'package:flutter/material.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/tap_detector.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

class StatusPreviewHome extends StatelessWidget {
  final String state; // "send" or "drop"
  final String dateTime; // Formatted as "Monday, 21/12/24 21:30"
  final String wasteStation; // Selected waste station
  final VoidCallback onTap; // Tap gesture handler

  const StatusPreviewHome({
    super.key,
    required this.state,
    required this.dateTime,
    required this.wasteStation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine state-related properties
    bool isSend = state == "Send";
    String actionText = isSend ? "Send Empties" : "Drop Empties";
    String imageAsset = isSend ? images.sendWaste : images.dropWaste;

    return GestureDetector(
      onTap: onTap, // Handle tap gesture
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: colors.yellow3, // Background color
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Section: Date & Time and Image
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date & Time
                Text(dateTime, style: textTheme.importantNotes),
                Gap(12.h),

                Row(
                  children: [
                    // Circle background with image
                    CircleAvatar(
                      backgroundColor: colors.green4,
                      radius: 24.0, // Size of the circle
                      child: Padding(
                        padding: const EdgeInsets.all(
                            6.0), // Adjust the gap size here
                        child: ClipOval(
                          child: Image.asset(
                            imageAsset,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Gap(8.0.w), // Spacing between image and text

                    // Action Text and Waste Station
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(actionText, style: textTheme.orderStationName),
                        Text(wasteStation, style: textTheme.badgesText),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            // Spacer to push the chevron icon to the right
            const Spacer(),

            // Right Section: Chevron Icon
            CircleAvatar(
              backgroundColor: colors.textButton,
              radius: 16.0,
              child: Icon(
                Icons.chevron_right,
                color: colors.background,
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
