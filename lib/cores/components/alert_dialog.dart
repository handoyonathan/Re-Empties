import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/constant/colors.dart';

class CustomAlertDialog extends StatelessWidget {
  final VoidCallback onConfirm; // Callback for the confirm button
  final VoidCallback onCancel; // Callback for the cancel button
  final bool logout;
  final bool isLocation; // New variable for location setting

  const CustomAlertDialog({
    super.key,
    required this.onConfirm,
    required this.onCancel,
    this.logout = false,
    this.isLocation = false, // Default value set to false
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: colors.bgColor,
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
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
              isLocation ? 'Location Permission Required' : 'Cancel',
              style: TextStyle(
                color: colors.green1,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              isLocation
                  ? 'This app requires location access to function properly.\nPlease enable location permissions in your device settings.'
                  : (logout
                      ? 'Are you sure you want to LOGOUT? \n This can\'t be undone.'
                      : 'Are you sure you want to cancel? \n This can\'t be undone.'),
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
              height: 0,
            ),
            // Conditional row based on isLocation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isLocation) ...[
                  // Back button
                  Flexible(
                    child: TextButton(
                      onPressed: onCancel,
                      style: TextButton.styleFrom(
                          foregroundColor: colors.green1,
                          overlayColor: Colors.transparent),
                      child: const Text(
                        'Back',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
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
                ],
                // Confirm button
                Flexible(
                  child: TextButton(
                    onPressed: onConfirm,
                    style: TextButton.styleFrom(
                        foregroundColor:
                            isLocation ? colors.green1: colors.red1,
                        overlayColor: Colors.transparent),
                    child: Text(
                      isLocation
                          ? 'Open App Settings'
                          : (logout ? 'Logout' : 'Cancel'),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
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
