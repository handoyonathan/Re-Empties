import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/custom_app_bar.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/admin/viewModel/fill_order_id_view_model.dart';
import 'package:re_empties/features/send_empties/widget/custom_pinput.dart';

class FillOrderID extends ConsumerStatefulWidget {
  FillOrderID({super.key})
      : _viewModel =
            ChangeNotifierProvider.autoDispose<FillOrderIdVM>(FillOrderIdVM.new);

  final AutoDisposeChangeNotifierProvider<FillOrderIdVM> _viewModel;

  @override
  ConsumerState createState() => FillOrderIdState();
}

class FillOrderIdState extends ConsumerState<FillOrderID> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      provider: widget._viewModel,
      appBar: (_) => const CustomAppBar(),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, FillOrderIdVM vm) => Scaffold(
        backgroundColor: colors.bgColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Enter DropID Code',
                style: textTheme.voucherCode,
              ),
              Gap(10.h),
              Text(
                'Kindly input the code provided by the customer',
                style: textTheme.pointLabel.copyWith(color: colors.green1),
              ),
              Gap(20.h),
              CustomPinput(
                formKey: vm.formKey,
                onFilled: vm.onFilled,
                getErrorText: vm.getErrorText,
                isAdmin: true,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: AppMainButton(
            state: ButtonState.primary,
            text: 'Verify Transaction',
            onPressed: () {},
          ),
        ),
      );
}
