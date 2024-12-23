import 'package:flutter/material.dart';
import 'package:re_empties/cores/components/article_preview_home.dart';
import 'package:re_empties/cores/components/banner_home.dart';
import 'package:re_empties/cores/components/alert_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:re_empties/cores/components/custom_details_card.dart';
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.all(16.0), // Add padding to the whole page
              child: Column(
                children: [
                  const CustomDetailsCard(
                    type: 'transaction',
                    data: {
                      'state': 'ongoing',
                      'plastic': 5,
                      'glass': 2,
                      'cardboard': 3,
                      'can': 4,
                      'total': 14,
                      'points': 1000,
                    },
                  ),
                  const CustomDetailsCard(
                    type: 'transaction',
                    data: {
                      'state': 'done',
                      'plastic': 5,
                      'glass': 2,
                      'cardboard': 3,
                      'can': 4,
                      'total': 14,
                      'points': 1000,
                    },
                  ),
                  const CustomDetailsCard(
                    type: 'payment',
                    data: {
                      'fee': "5.000",
                      'subtotal': "20.000",
                      'total': "25.000",
                    },
                  ),

                  // Uncomment below as needed
                  const ReedemPointsCard(points: '12.000'),
                  const SizedBox(height: 10),
                  // const VoucherCardRedeem(
                  //   category: 'games',
                  //   title: '100 Diamonds in Game Legends',
                  //   description:
                  //       'Receive 100 in-game diamonds for Game Legends. efeflke fkdnfl nlfndls kffefefklnedf fefefcdf ffdnfdf fedf sfd',
                  //   points: '150',
                  //   isUsed: false, // Not used
                  //   isOutOfStock: false, // Available to redeem
                  // ),
                  // const VoucherCardRedeem(
                  //   category: 'shopping',
                  //   title: 'Free Shipping on Orders Over Rp 30.000',
                  //   description:
                  //       r'Enjoy free shipping on orders over $30 at MegaShop.',
                  //   points: '500',
                  //   isUsed: false, // Not used
                  //   isOutOfStock:
                  //       true, // Indicating this voucher is out of stock
                  // ),
                  // const VoucherCardRedeem(
                  //   category: 'food',
                  //   title: 'Discount 20% at Burger Town',
                  //   description:
                  //       'Enjoy a 20% discount on your total purchase at any participating Burger Town location.',
                  //   points: '200',
                  //   isUsed: true, // Indicating this voucher has been used
                  //   isOutOfStock: true, // Not out of stock
                  // ),
                  // const SizedBox(height: 10),
                  // StatusPreviewHome(
                  //   state: "send", // or "drop"
                  //   dateTime: "Monday, 21/12/24 21:30",
                  //   wasteStation: "Green Valley Recycling Center",
                  //   onTap: () {
                  //     print("Card tapped!");
                  //   },
                  // ),
                  // const SizedBox(height: 10),
                  // StatusPreviewHome(
                  //   state: "drop", // or "drop"
                  //   dateTime: "Monday, 21/12/24 21:30",
                  //   wasteStation: "waste station kemanggisan",
                  //   onTap: () {
                  //     print("Card tapped!");
                  //   },
                  // ),
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
