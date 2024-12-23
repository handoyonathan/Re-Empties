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
  final bool isUsed;
  final bool isOutOfStock;
  final VoidCallback onTap;

  const VoucherCardRedeem({
    super.key,
    required this.category,
    required this.title,
    required this.description,
    required this.points,
    this.isUsed = false,
    this.isOutOfStock = false,
    required this.onTap,
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
    // Determine if the voucher is disabled
    final bool isDisabled = isUsed || isOutOfStock;

    // Determine the background color
    final Color backgroundColor = isDisabled ? colors.gray2 : colors.yellow4;

    // Determine the additional text
    final String? additionalText = isUsed
        ? "You have used this voucher"
        : isOutOfStock
            ? "The voucher is out of stock"
            : null;

    return GestureDetector(
      onTap: isDisabled
          ? null // Disable interaction if the voucher is used or out of stock
          : onTap,
      child: Card(
        elevation: 4,
        color: backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Row(
            children: [
              Image.asset(
                getImagePath(),
                height: 68.0,
                width: 68.0,
                fit: BoxFit.cover,
              ),
              Gap(10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.myPoint.copyWith(
                        color: colors.green1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(4.h),
                    Text(
                      description,
                      style: textTheme.homeShipLabel2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (additionalText != null) ...[
                      Gap(4.h),
                      Text(
                        additionalText,
                        style: textTheme.pointLabel.copyWith(
                          color: colors.red1,
                        ),
                      ),
                    ],
                    Gap(8.h),
                    if (!isDisabled)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: colors.green2,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            'Use $points points',
                            style: textTheme.pointLabel.copyWith(
                              color: colors.bgColor,
                            ),
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
