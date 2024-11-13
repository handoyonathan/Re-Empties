import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/components/tap_detector.dart';
import 'custom_sheet_voucher.dart';

class VoucherCardRedeem extends StatelessWidget {
  final String category;
  final String title;
  final String description;
  final String points;

  const VoucherCardRedeem({
    super.key,
    required this.category,
    required this.title,
    required this.description,
    required this.points,
  });

  // Helper function to select the image based on the category
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
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return CustomSheetVoucher(
              imagePath: getImagePath(),
              title: title,
              description: description,
              points: points,
            ); // Display the custom sheet here
          },
        );
      },
      child: Card(
        elevation: 4,
        color: colors.yellow4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Row(
            children: [
              Image.asset(
                getImagePath(),
                height: 72.0,
                width: 72.0,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.myPoint.copyWith(color: colors.green1),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      description,
                      style: textTheme.homeShipLabel2,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: colors.red5,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '-$points points',
                          style: textTheme.pointLabel
                              .copyWith(color: colors.green1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
