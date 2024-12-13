import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/custom_app_bar.dart';
import 'package:re_empties/cores/components/loading_indicator.dart';
import 'package:re_empties/cores/components/tap_detector.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/send_empties/model/location_model.dart';
import 'package:re_empties/features/send_empties/viewModel/drop_point_detail_view_model.dart';
import 'package:re_empties/features/send_empties/widget/custom_pinput.dart';

class DropPointDetailView extends ConsumerWidget {
  final bool isSend;
  final Admin wasteLocation;
  final String transactionId;
  final AutoDisposeChangeNotifierProvider<DropPointDetailVM> _viewModel;

  DropPointDetailView({
    super.key,
    required this.wasteLocation,
    required this.isSend,
    required this.transactionId,
  }) : _viewModel = ChangeNotifierProvider.autoDispose(
          (ref) => DropPointDetailVM(ref, wasteLocation: wasteLocation, transactionId: transactionId),
        );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(_viewModel);

    return BaseView(
      provider: _viewModel,
      appBar: (_) => CustomAppBar(
        showLeading: false,
        title: Text(
          'Drop Point Detail',
          style: textTheme.textButton.copyWith(color: colors.green1),
        ),
        actions: [
          TapDetector(
            child: Icon(
              Icons.close_rounded,
              color: colors.green1,
            ),
            onTap: () {
              Navigator.of(context).maybePop();
            },
          ),
        ],
      ),
      builder: (context, vm) => _buildScreen(context, viewModel),
    );
  }

  Widget _buildScreen(BuildContext context, DropPointDetailVM vm) {
    return Scaffold(
      backgroundColor: colors.bgColor,
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wasteLocation.stationName,
                    style: textTheme.formName,
                    textAlign: TextAlign.start,
                  ),
                  Gap(5.h),
                  Text(
                    wasteLocation.adminPhone,
                    style: textTheme.label,
                    textAlign: TextAlign.start,
                  ),
                  Gap(5.h),
                  Text(
                    wasteLocation.addressStation,
                    style: textTheme.label,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Gap(20.h),
            Container(
              width: double.infinity,
              height: 150.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: vm.position != null
                  ? GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: vm.position!,
                        zoom: 16.0,
                      ),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      onMapCreated: vm.onMapCreated,
                      markers: vm.markers,
                    )
                  : const Center(
                      child: LoadingIndicator(),
                    ),
            ),
            Gap(50.h),
            Text('Your dropID', style: textTheme.subtitle),
            Gap(20.h),
            CustomPinput(
                formKey: vm.formKey,
                onFilled: vm.onFilled,
                getErrorText: vm.getErrorText,
                isAdmin: false,),
            Gap(40.h),
            Text(
              'The admin is notified and will help you if you arrived',
              style: textTheme.textFieldLabel.copyWith(fontSize: 13.sp),
              textAlign: TextAlign.center,
            ),
            Gap(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You will get ', style: textTheme.successPointLabel.copyWith(fontSize: 14.sp)),
                Text('100 points / pcs', style: textTheme.detailDropPoint.copyWith(fontSize: 14.sp)),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: colors.bgColor,
        alignment: Alignment.center,
        height: 70.h,
        child: AppMainButton(
          state: ButtonState.cancel,
          text: 'Cancel',
           onPressed: () => vm.showCancelDialog(context),
        ),
      ),
    );
  }
}
