import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/custom_app_bar.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/components/tap_detector.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/admin/viewModel/admin_view_model.dart';
import 'package:re_empties/features/admin/widget/filter_button.dart';
import 'package:re_empties/features/admin/widget/transaction_card.dart';

class AdminView extends StatefulWidget {
  AdminView({super.key})
      : _viewModel = ChangeNotifierProvider.autoDispose<AdminViewVM>(AdminViewVM.new);

  final AutoDisposeChangeNotifierProvider<AdminViewVM> _viewModel;

  @override
  AdminViewState createState() => AdminViewState();
}

class AdminViewState extends State<AdminView> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      provider: widget._viewModel,
      appBar: (_) => CustomAppBar(
        showLeading: false,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'On Going Transaction',
            style: textTheme.title,
          ),
        ),
        actions: [
          TapDetector(
            onTap: (){},
            child: ImageAsset(
              imagePath: images.adminProfile,
              fit: BoxFit.fill,
              width: 32.w,
              height: 32.h,
            ),
          ),
          Gap(8.w)
        ],
      ),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, AdminViewVM vm) => Scaffold(
        backgroundColor: colors.bgColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FilterButton(label: 'All', isSelected: true, onTap: () {}),
                  Gap(8.w),
                  FilterButton(label: 'Send Empties', isSelected: false, onTap: () {}),
                  Gap(8.w),
                  FilterButton(label: 'Drop Empties', isSelected: false, onTap: () {}),
                ],
              ),
              Gap(16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: 5, // number of transactions
                  itemBuilder: (context, index) {
                    return const TransactionCard();
                  },
                ),
              ),
            ],
          ),
        ),
      );
}