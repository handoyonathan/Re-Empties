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

class AdminView extends StatefulWidget {
  AdminView({super.key})
      : _viewModel = ChangeNotifierProvider.autoDispose<AdminVM>(AdminVM.new);

  final AutoDisposeChangeNotifierProvider<AdminVM> _viewModel;

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

  Widget _buildScreen(BuildContext context, AdminVM vm) => Scaffold(
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
                  FilterButton(label: 'All', isSelected: true),
                  Gap(8.w),
                  FilterButton(label: 'Send Empties', isSelected: false),
                  Gap(8.w),
                  FilterButton(label: 'Drop Empties', isSelected: false),
                ],
              ),
              Gap(16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: 5, // number of transactions
                  itemBuilder: (context, index) {
                    return TransactionCard();
                  },
                ),
              ),
            ],
          ),
        ),
      );
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const FilterButton(
      {super.key, required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return TapDetector(
      onTap: (){},
        child: Container(
      decoration: BoxDecoration(
        color: isSelected ? colors.green3 : colors.yellow2,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.r),
        child: Center(
          child: Text(
            label,
            style: textTheme.detailDropPointLabel
                .copyWith(color: isSelected ? colors.bgColor : colors.green1),
          ),
        ),
      ),
    ));
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key});

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
          title: Row(
            children: [
              Text(
                'Nama - ',
                style: textTheme.title,
              ),
              Text(
                'Tipe Orderan',
                style: textTheme.title,
              ),
            ],
          ),
          subtitle: Text(
            'Jl. Raya Kb. Jeruk No.27, RT.1/RW.9, Kemanggisan, Kec. Palmerah, Kota Jakarta Barat, Daerah Khusus Ibukota Jakarta 11530',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: colors.green1),
        ),
      ),
    );
  }
}
