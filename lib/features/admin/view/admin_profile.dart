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
import 'package:re_empties/features/admin/viewModel/admin_view_model.dart';

class AdminProfile extends StatefulWidget {
  AdminProfile({super.key})
      : _viewModel =
            ChangeNotifierProvider.autoDispose<AdminViewVM>(AdminViewVM.new);

  final AutoDisposeChangeNotifierProvider<AdminViewVM> _viewModel;

  @override
  AdminViewState createState() => AdminViewState();
}

class AdminViewState extends State<AdminProfile> {
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

  Widget _buildScreen(BuildContext context, AdminViewVM vm) => Scaffold(
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
                'Waste Station Kemanggisan',
                style: textTheme.title,
              ),
              Gap(10.h),
              Text(
                'Jl. Ks. Tubun III Dalam No.32, RT.2/RW.3, Slipi, Kec. Palmerah, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11410',
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
            onPressed: () {},
          ),
        ),
      );
}
