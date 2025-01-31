import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/components/navbar/navbar_model.dart';
import 'package:re_empties/cores/constant/colors.dart';

class BottomNavBar extends StatelessWidget {
  final List<NavBarModel> tabList;
  final int selectedIndex;
  final Function(int) setIndex;

  const BottomNavBar({
    super.key,
    required this.tabList,
    required this.selectedIndex,
    required this.setIndex,
  });

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r), 
        topRight: Radius.circular(20.r),
      ),
    child: BottomAppBar(
      height: 70.h,
      color: colors.gray2,
      padding: EdgeInsets.zero,
      shape: const CircularNotchedRectangle(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap(20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: tabList.map((e) {
              int index = tabList.indexOf(e);
              bool selected = selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  setIndex(index);
                },
                child: Column(
                  children: [
                    ImageAsset(
                      imagePath: 
                      e.icon[selected]!,
                      width: 26.w,
                      height: 26.w,
                    ),
                    Gap(20.h),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}
