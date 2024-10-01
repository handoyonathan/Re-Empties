import 'package:flutter/material.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/components/tap_detector.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

class StatusPreviewHome extends StatelessWidget {
  final String status;
  final String id;
  final String delivery;
  final VoidCallback onTap; // Accept onTap function as a parameter

  const StatusPreviewHome(
      {super.key,
      required this.status,
      required this.id,
      required this.delivery,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TapDetector(
      onTap: onTap,
      child: Card(
        color: colors.yellow3,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r))),
        child: Column(
          children: [
            // Top Section: Circle with truck icon and text
            Padding(
              padding: EdgeInsets.all(12.h),
              child: Row(
                children: [
                  // Circle with truck icon
                  CircleAvatar(
                    backgroundColor: colors.textButton,
                    radius: 15.r,
                    child: Icon(
                      Icons.local_shipping,
                      color: colors.bgColor,
                      size: 20.r,
                    ),
                  ),
                  Gap(5.w),
                  Text(
                    status,
                    style: textTheme.homeShipLabel1,
                  ),
                ],
              ),
            ),
            // Horizontal Divider without padding
            Divider(
              thickness: 1,
              height: 0,
              color: colors.yellow5,
            ),

            // Row with Tracking ID, vertical divider, and Estimated Delivery
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Tracking ID text
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 12.h), // Padding for text
                    child: Column(
                      children: [
                        Text(
                          "Tracking ID",
                          style: textTheme.label,
                        ),
                        Text(
                          id,
                          style: textTheme.appbarTitle,
                        ),
                      ],
                    ),
                  ),
                ),

                // Vertical Divider
                Container(
                  width: 1,
                  height: 40, // Set height for visibility
                  color: colors.yellow5, // Color for the divider
                ),

                // Estimated Delivery text
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 12.h), // Padding for text
                    child: Column(
                      children: [
                        Text(
                          "Estimated Delivery",
                          style: textTheme.label,
                        ),
                        Text(
                          delivery,
                          style: textTheme.appbarTitle,
                        ),
                      ],
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
