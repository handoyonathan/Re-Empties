import 'package:flutter/material.dart';
import 'package:re_empties/cores/components/article_preview_home.dart';
import 'package:re_empties/cores/components/banner_home.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/alert_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/points_card_home.dart';
import 'package:re_empties/cores/components/send_drop_card.dart';
import 'package:re_empties/cores/components/status_preview_home.dart';
import 'package:re_empties/cores/components/tap_detector.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: colors.background,
        body: Stack(
          children: [
            // Banner that covers the top part of the screen
            const Positioned.fill(
                top: 0,
                bottom: null,
                left: 0,
                right: 0,
                child: BannerHome(level: 5)),

            // Positioned content starting below the banner with a gap of 18.h
            Positioned(
              top: 220.0
                  .h, // Adjust this value based on your banner's height + gap
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical:
                        0), // Remove vertical padding to control the position using Positioned
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    HomePointsCard(onTap: () {
                      print("points");
                    }),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Space out the two cards
                      children: [
                        HomeSendDropCard(
                          state: SendDropState.drop,
                          onTap: () {
                            print("drop card");
                          },
                        ),
                        HomeSendDropCard(
                          state: SendDropState.send,
                          onTap: () {
                            print("send card");
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    StatusPreviewHome(
                      status: 'Your item is being shipped',
                      id: 'SE-001',
                      delivery: 'DD-MM-YYYY',
                      onTap: () {
                        print("tracking status clicked");
                      },
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft, // Align to the left
                      child: Text(
                        "Articles",
                        style: textTheme.title,
                      ),
                    ),
                    ArticlePreviewHome(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show dialog for Cancel button
  static void showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          onConfirm: () {
            // Action when cancel is confirmed
            print("Cancel confirmed");
            Navigator.pop(context); // Close the dialog
          },
          onCancel: () {
            // Action when back button is pressed
            print("Cancel back pressed");
            Navigator.pop(context); // Close the dialog
          },
        );
      },
    );
  }
}
