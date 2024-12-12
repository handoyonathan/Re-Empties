import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:re_empties/cores/components/tap_detector.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';

class TransactionCard extends StatelessWidget {
  final String name;
  final String transactionType;
  final String address;
  final VoidCallback onTap;

  const TransactionCard(
      {super.key,
      required this.onTap,
      required this.name,
      required this.transactionType,
      required this.address});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Container(
        decoration: BoxDecoration(
          color: colors.green6,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: colors.green1, width: 2),
        ),
        child: ListTile(
          title: Text(
            '$name - $transactionType',
            style: textTheme.title,
          ),
          subtitle: Text(
            address,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: TapDetector(
              onTap: onTap,
              child: Icon(Icons.arrow_forward_ios, color: colors.green1)),
        ),
      ),
    );
  }
}
