import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/constant/colors.dart';

class CustomAlertDialog extends StatelessWidget {
  final VoidCallback onConfirm; // Callback for the confirm button
  final VoidCallback onCancel; // Callback for the cancel button

  const CustomAlertDialog({
    super.key,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: colors.bgColor,
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        // width: MediaQuery.of(context).size.width / 2,
        // height: MediaQuery.of(context).size.height / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(10.h),
            // Warning icon with circle background
            CircleAvatar(
              backgroundColor: colors.red1, // Circle background color
              radius: 35.r, // Adjust size as needed
              child: const Icon(
                Icons.warning, // Warning icon
                color: Colors.white, // Icon color
                size: 45, // Icon size
              ),
            ),
            Gap(10.h), // Space between icon and text
            Text(
              'Cancel',
              style: TextStyle(
                color: colors.green1,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),

            Text(
              'Are you sure you want to cancel? \n This can\'t be undone.',
              style: TextStyle(
                color: colors.green1,
                fontWeight: FontWeight.normal,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(20.h),
            const Divider(
              thickness: 1,
              color: Color(0xFFDADADA),
              height: 0, // Set height to 0 for perfect line fit
            ),
            // Row with two buttons and a vertical divider
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Back button
                Flexible(
                  child: TextButton(
                    onPressed: onCancel, // Pass onCancel callback
                    style: TextButton.styleFrom(
                        foregroundColor: colors.green1,
                        overlayColor: Colors.transparent),
                    child: const Text(
                      'Back',
                      style: TextStyle(
                        fontWeight: FontWeight.normal, // Regular text
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Gap(20.w),
                SizedBox(
                  height: 40.h,
                  child: const VerticalDivider(
                    thickness: 1,
                    color: Color(0xFFDADADA),
                  ),
                ),
                Gap(20.w),
                // Confirm button
                Flexible(
                  child: TextButton(
                    onPressed: onConfirm, // Pass onConfirm callback
                    style: TextButton.styleFrom(
                        foregroundColor: colors.red1,
                        // padding: const EdgeInsets.symmetric(vertical: 8),
                        overlayColor: Colors.transparent),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Bold text
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
