import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/custom_app_bar.dart';
import 'package:re_empties/cores/components/custom_details_card.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/order/viewmodel/order_summary_viewmodel.dart';
import 'package:re_empties/features/send_empties/widget/delivery_detail_container.dart';

class OrderSummaryView extends StatelessWidget {
  final AutoDisposeChangeNotifierProvider<OrderSummaryVM> _viewModel;
  final String transactionID;

  OrderSummaryView({super.key, required this.transactionID})
      : _viewModel = ChangeNotifierProvider.autoDispose(
            (ref) => OrderSummaryVM(ref, transactionID: transactionID));

  @override
  Widget build(BuildContext context) => BaseView<OrderSummaryVM>(
        provider: _viewModel,
        appBar: (_) => CustomAppBar(
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Order Summary',
              style: textTheme.appbarTitle,
            ),
          ),
          backgroundColor: colors.bgColor,
        ),
        builder: _buildScreen,
        disableSafeArea: false,
      );

  Widget _buildScreen(BuildContext context, OrderSummaryVM vm) {
    if (vm.isError) {
      return Center(
        child: Text(
          'An error occurred while loading the order summary.',
          style: textTheme.appbarTitle.copyWith(color: colors.gray3),
        ),
      );
    }

    // Tampilkan loader jika `transaction` masih null
    if (vm.transaction == null) {
      return Scaffold(
        backgroundColor: colors.bgColor,
        body: Center(
          child: CircularProgressIndicator(
            color: colors.green2,
          ),
        ),
      );
    }

    // Akses data `vm.transaction` setelah memastikan nilainya tidak null
    final transaction = vm.transaction!;

    return Scaffold(
      backgroundColor: colors.bgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(7.w),
                  width: 42.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    color: colors.green4,
                    shape: BoxShape.circle,
                  ),
                  child: ImageAsset(
                    imagePath: transaction.transactionType == 'Send'
                        ? images.sendWaste
                        : images.dropWaste,
                  ),
                ),
                Gap(10.w),
                Text(
                  '${transaction.transactionType} Your Waste',
                  style: textTheme.orderType,
                ),
                Expanded(
                  child: Text(
                    '${transaction.date} ${transaction.time}',
                    style: textTheme.homeShipLabel2,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
            Gap(10.h),
            Divider(
              color: colors.gray4,
              height: 1.h,
            ),
            Gap(10.h),
            Text(
              transaction.orderStatus == 'Delivery'
                  ? '${transaction.transactionType} Ongoing'
                  : transaction.orderStatus == 'Verify'
                      ? '${transaction.transactionType} Finished'
                      : '${transaction.transactionType} Canceled',
              style: textTheme.appbarTitle.copyWith(
                color: transaction.orderStatus == 'Canceled'
                    ? colors.red1
                    : colors.green1,
              ),
            ),
            Gap(20.h),
            Row(
              children: [
                ImageAsset(
                  imagePath: images.address,
                  width: 38.w,
                  height: 180.h,
                ),
                Gap(5.w),
                Expanded(
                  child: Column(
                    children: [
                      DeliveryDetailContainer(
                        isUser: true,
                        name: vm.userFullName,
                        phoneNumber: vm.userPhoneNum,
                        address: vm.userAddress,
                      ),
                      Gap(15.h),
                      DeliveryDetailContainer(
                        isUser: false,
                        name: vm.adminFullName,
                        phoneNumber: vm.adminPhoneNum,
                        address: vm.adminAddress,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Gap(20.h),
            Visibility(
              visible: transaction.orderStatus == "Verify",
              child: Column(
                children: [
                  CustomDetailsCard(
                    type: 'transaction',
                    data: {
                      'state': transaction.orderStatus == 'Delivery' ? 'ongoing' : 'done',
                      'plastic': transaction.plasticWeight,
                      'glass': transaction.glassWeight,
                      'cardboard': transaction.cardboardWeight,
                      'total': transaction.totalWastePcs,
                    },
                  ),
                  Gap(15.h),
                ],
              ),
            ),
            Visibility(
              visible: transaction.transactionType == 'Send' &&
                  transaction.orderStatus != 'Canceled',
              child: CustomDetailsCard(
                type: 'payment',
                data: {
                  'fee': transaction.deliveryFee,
                  'subtotal': transaction.deliveryFee,
                  'total': transaction.deliveryFee,
                },
              ),
            ),
            Visibility(
              visible: transaction.transactionType == 'Drop' &&
                  transaction.orderStatus == 'Delivery',
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                width: double.infinity,
                height: 40.h,
                decoration: BoxDecoration(
                  color: colors.yellow4,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Drop ID',
                      style: textTheme.orderStationName,
                    ),
                    Text(
                      '${transaction.dropID}',
                      style: textTheme.orderStationName,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: transaction.orderStatus == 'Delivery' &&
              transaction.transactionType == 'Drop'
          ? Container(
              color: colors.bgColor,
              alignment: Alignment.center,
              height: 70.h,
              child: AppMainButton(
                state: ButtonState.cancel,
                text: 'Cancel',
                onPressed: () {
                  // vm.goToFormPage(isSend: widget.isSend);
                  vm.showCancelDialog(context);
                },
              ),
            )
          : null,
    );
  }
}
