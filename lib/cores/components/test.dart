import 'package:flutter/material.dart';
import 'package:re_empties/cores/components/article_preview_home.dart';
import 'package:re_empties/cores/components/banner_home.dart';
import 'package:re_empties/cores/components/alert_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:re_empties/cores/components/points_card_home.dart';
import 'package:re_empties/cores/components/points_card_reedem.dart';
import 'package:re_empties/cores/components/send_drop_card.dart';
import 'package:re_empties/cores/components/status_preview_home.dart';
import 'package:re_empties/cores/components/tap_detector.dart';
import 'package:re_empties/cores/components/voucher_card_reedem.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: colors.background,
        body: const SafeArea(
          // Ensures content starts after the safe area
          child: Padding(
            padding: EdgeInsets.all(16.0), // Add padding to the whole page
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ReedemPointsCard(points: '12.000'),
                  SizedBox(height: 10),
                  VoucherCardRedeem(
                    category: 'games',
                    title: '100 Diamonds in Game Legends',
                    description:
                        'Receive 100 in-game diamonds for Game Legends. efeflke fkdnfl nlfndls kffefefklnedf fefefcdf ffdnfdf fedf sfd',
                    points: '150',
                    isUsed: false, // Not used
                    isOutOfStock: false, // Available to redeem
                  ),
                  VoucherCardRedeem(
                    category: 'shopping',
                    title: 'Free Shipping on Orders Over Rp 30.000',
                    description:
                        r'Enjoy free shipping on orders over $30 at MegaShop.',
                    points: '500',
                    isUsed: false, // Not used
                    isOutOfStock:
                        true, // Indicating this voucher is out of stock
                  ),
                  VoucherCardRedeem(
                    category: 'food',
                    title: 'Discount 20% at Burger Town',
                    description:
                        'Enjoy a 20% discount on your total purchase at any participating Burger Town location.',
                    points: '200',
                    isUsed: true, // Indicating this voucher has been used
                    isOutOfStock: true, // Not out of stock
                  ),
                ],
              ),
            ),
          ),
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
