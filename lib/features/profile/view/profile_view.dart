import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/banner_home.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/hidden_app_bar.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/components/points_card_home.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/profile/view%20model/profile_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatefulWidget {
  ProfileView({super.key})
      : _viewmodel =
            ChangeNotifierProvider.autoDispose<ProfileVM>(ProfileVM.new);

  final AutoDisposeChangeNotifierProvider<ProfileVM> _viewmodel;

  @override
  State<StatefulWidget> createState() => ProfileViewState();
}

class ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      provider: widget._viewmodel,
      appBar: (_) => const HiddenAppBar(
        backgroundColor: Colors.transparent,
      ),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, ProfileVM vm) => Scaffold(
        backgroundColor: colors.bgColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ImageAsset(
                    imagePath: images.profileUser,
                    width: 143.w,
                    height: 143.h,
                  ),
                ),
                Gap(16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      vm.userFullName,
                      style: textTheme.title,
                    ),
                    GestureDetector(
                      onTap: () {
                        vm.goToEdit();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Edit Profile',
                            style: textTheme.detailDropPointLabel,
                          ),
                          Gap(2.h),
                          Icon(
                            Icons.edit,
                            color: colors.green1,
                            size: 18.sp,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                // Gap(4.h),
                Text(
                  vm.userPhoneNum,
                  style: textTheme.label,
                ),
                // Gap(4.h),
                Text(
                  vm.userEmail,
                  style: textTheme.label,
                ),
                Gap(10.h),
                Divider(color: colors.gray1),
                Gap(8.h),
                Text(
                  'Your Level',
                  style: textTheme.title,
                ),
                Gap(11.h),
                BannerHome(
                  totalPoints: vm.totalPoints,
                  availablePoints: vm.point,
                  level: 5,
                  isProfilePage: true,
                ),
                Gap(16.h),
                Divider(color: colors.gray1),
                Gap(8.h),
                Text(
                  'Your Points',
                  style: textTheme.title,
                ),
                HomePointsCard(
                  onTap: () {
                    vm.goToVoucherPage();
                  },
                  points: vm.point,
                ),
                Gap(16.h),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: AppMainButton(
            state: ButtonState.primary,
            text: 'logout',
            onPressed: () {
              vm.logout(context);
            },
          ),
        ),
      );
}
