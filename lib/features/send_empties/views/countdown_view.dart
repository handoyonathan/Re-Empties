import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/features/send_empties/viewModel/countdown_viewmodel.dart';
import 'package:re_empties/cores/components/hidden_app_bar.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';

class CountdownView extends ConsumerStatefulWidget {
  CountdownView({
    super.key,
    required this.transactionId,
    required this.point
  }) : _viewModel = ChangeNotifierProvider.autoDispose<CountdownViewModel>(
            (ref) => CountdownViewModel(ref, transactionId: transactionId, point: point));

  final String transactionId;
  final int point;
  final AutoDisposeChangeNotifierProvider<CountdownViewModel> _viewModel;

  @override
  CountdownViewState createState() => CountdownViewState();
}

class CountdownViewState extends ConsumerState<CountdownView> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      provider: widget._viewModel,
      appBar: (_) => const HiddenAppBar(),
      builder: _buildScreen,
    );
  }

  Widget _buildScreen(BuildContext context, CountdownViewModel vm) {
    return Scaffold(
      backgroundColor: colors.bgColor,
      bottomNavigationBar: Container(
        color: colors.bgColor,
        alignment: Alignment.center,
        height: 70.h,
        child: AppMainButton(
          state: ButtonState.cancel,
          text: 'Cancel',
          onPressed: () {
            vm.showCancelDialog(context);
            // widget.onCancel();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          children: [
            Gap(50.h),
            Stack(
              alignment: Alignment.center,
              children: [
                ImageAsset(
                  imagePath: images.countDown,
                  width: 305.w,
                  height: 305.h,
                ),
                Text(
                  '${vm.countdown}',
                  style: textTheme.countdown,
                ),
              ],
            ),
            Gap(50.h),
            Text(
              'Searching for driver...',
              style: textTheme.successTitle.copyWith(
                decoration: TextDecoration.none,
              ),
            ),
            Gap(5.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Text(
                'We are searching a driver to pick up the package and drop it off at the waste station',
                style: textTheme.label.copyWith(
                  decoration: TextDecoration.none,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
