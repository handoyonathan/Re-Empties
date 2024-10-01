import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

class WasteLocationCard extends StatelessWidget {
  final String title;
  final String address;
  final String openHour;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isOpen;
  final String distance;

  const WasteLocationCard({super.key, 
    required this.title,
    required this.address,
    required this.openHour,
    required this.isSelected,
    required this.onTap,
    this.isOpen = false,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? colors.green6 : colors.gray2,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? colors.green3 : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: textTheme.locationName.copyWith(fontWeight: FontWeight.w700),),
                  Gap(5.h),
                  Text(openHour, style: textTheme.locationDescription,),
                  Gap(5.h),
                  Text(address, style: textTheme.label,),
                ],
              ),
            ),
            Gap(50.h),
            Text(distance, textAlign: TextAlign.start,),
          ],
        )
      ),
    );
  }
}
