import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/custom_app_bar.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/admin/viewModel/admin_profile_view_model.dart';

class AdminProfile extends StatefulWidget {
  AdminProfile({super.key})
      : _viewModel =
            ChangeNotifierProvider.autoDispose<AdminProfileVM>(AdminProfileVM.new);

  final AutoDisposeChangeNotifierProvider<AdminProfileVM> _viewModel;

  @override
  AdminProfileState createState() => AdminProfileState();
}

class AdminProfileState extends State<AdminProfile> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      provider: widget._viewModel,
      appBar: (_) => CustomAppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Profile',
            style: textTheme.title,
          ),
        ),
      ),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, AdminProfileVM vm) => Scaffold(
        backgroundColor: colors.bgColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageAsset(
                imagePath: images.adminProfile,
                width: 220.w,
                height: 220.h,
              ),
              Gap(10.h),
              Text(
                vm.adminName,
                style: textTheme.title,
                textAlign: TextAlign.center,
              ),
              Gap(10.h),
              Text(
                vm.addressStation,
                style: textTheme.label,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: AppMainButton(
            state: ButtonState.primary,
            text: 'logout',
            onPressed: () {
              vm.logout();
            },
          ),
        ),
      );
}
