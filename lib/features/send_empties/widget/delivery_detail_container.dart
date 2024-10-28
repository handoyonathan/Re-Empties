import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

class DeliveryDetailContainer extends StatelessWidget {
  final bool isUser;
  final String name;
  final String phoneNumber;
  final String address;

  const DeliveryDetailContainer({
    super.key,
    required this.isUser,
    required this.name,
    required this.phoneNumber,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: !isUser ? colors.green6 : colors.yellow3,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: !isUser ? colors.green3 : colors.yellow1,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: textTheme.formName,
              ),
              Gap(2.h),
              Text(
                phoneNumber,
                style: textTheme.label,
              ),
              Gap(4.h),
              Text(
                address,
                style: textTheme.label,
                maxLines: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
