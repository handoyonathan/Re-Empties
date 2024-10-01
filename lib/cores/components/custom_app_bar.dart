import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/tap_detector.dart';
import 'package:re_empties/cores/constant/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final bool showLeading;
  final List<Widget>? actions;
  final Widget? title;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    this.title,
    this.leading,
    this.showLeading = true,
    this.actions,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) => AppBar(
        backgroundColor: backgroundColor ?? colors.bgColor,
        leading: showLeading
            ? Padding(
                padding: EdgeInsets.all(8.w),
                child: leading ??
                    TapDetector(
                      child: Icon(Icons.arrow_back_ios_new_sharp, color: colors.green1,),
                      onTap: () {
                        Navigator.of(context).maybePop();
                      },
                    ),
              )
            : null,
        automaticallyImplyLeading: false,
        actions: [Gap(8.w), ...(actions ?? []), Gap(8.w)],
        elevation: 0,
        titleSpacing: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: Padding(
          padding: showLeading ? EdgeInsets.zero : EdgeInsets.only(left: 16.w),
          child: title,
        ),
      );

  @override
  Size get preferredSize =>
      Size(double.maxFinite, AppBar().preferredSize.height);
}
