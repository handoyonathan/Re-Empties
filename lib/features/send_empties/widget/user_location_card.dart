import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

class UserLocationCard extends StatelessWidget {
  final String title;
  final String address;
  
  final bool isSelected;
  final VoidCallback onTap;

  const UserLocationCard({super.key, 
    required this.title,
    required this.address,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? colors.yellow3 : colors.gray2,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? colors.yellow1 : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: isSelected ? colors.yellow1 : Colors.grey,
            ),
            Gap(10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.orderStationName,
                  ),
                  Text(
                    address,
                    style: textTheme.label,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
