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
import 'package:re_empties/features/admin/viewModel/transaction_detail_view_model.dart';
import 'package:re_empties/features/send_empties/model/transaction_model.dart';
import 'package:re_empties/features/send_empties/widget/delivery_detail_container.dart';
import 'package:re_empties/features/send_empties/widget/stepper.dart';

class TransactionDetailView extends ConsumerStatefulWidget {
  final TransactionModel transaction;
  final String transactionID;
  final bool isSend;
  TransactionDetailView({
    super.key,
    required this.isSend,
    required this.transaction,
    required this.transactionID,
  }) : _viewModel = ChangeNotifierProvider.autoDispose<TransactionDetailVM>(
          (ref) => TransactionDetailVM(
            ref,
            transactionID: transactionID,
          ),
        );

  final AutoDisposeChangeNotifierProvider<TransactionDetailVM> _viewModel;

  @override
  ConsumerState createState() => SendFormState();
}

class SendFormState extends ConsumerState<TransactionDetailView> {
  @override
  Widget build(BuildContext context) => BaseView(
        provider: widget._viewModel,
        appBar: (_) => CustomAppBar(
          title: Text('Transaction Detail', style: textTheme.orderStationName),
        ),
        builder: _buildScreen,
      );

  Widget _buildScreen(BuildContext context, TransactionDetailVM vm) => Scaffold(
        backgroundColor: colors.bgColor,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.isSend ? 'Send Waste' : 'Drop Off Waste',
                      style: textTheme.orderStationName,
                    ),
                    Text(
                      widget.transactionID,
                      style: textTheme.label.copyWith(color: colors.black),
                    ),
                  ],
                ),
                if (widget.isSend) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery Partner',
                        style: textTheme.formName,
                      ),
                      Text(widget.transaction.deliveryOption!,
                          style: textTheme.label),
                    ],
                  ),
                ],
                Gap(10.h),
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
                            name: vm.adminName,
                            phoneNumber: vm.adminPhoneNum,
                            address: vm.adminAddress,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Gap(30.h),
                Text(
                  'Waste Category',
                  style: textTheme.title,
                ),
                Gap(5.h),
                Divider(
                  color: colors.gray4,
                  height: 1.h,
                ),
                Gap(5.h),
                ...vm.wasteCategories.map((category) {
                  return Column(
                    children: [
                      WasteCategoryStepper(
                        title: category.title,
                        description: category.desc,
                        imagePath: category.image,
                        quantity: vm.wasteWeight[category.id] ?? 0,
                        onIncrease: () => vm.increaseQuantity(category.id),
                        onDecrease: () => vm.decreaseQuantity(category.id),
                      ),
                      Gap(10.h),
                      Divider(color: colors.gray4, height: 1.h),
                      Gap(10.h),
                    ],
                  );
                }),
                Gap(20.h),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: colors.bgColor,
          alignment: Alignment.center,
          height: 70.h,
          child: AppMainButton(
            state: ButtonState.primary,
            text: widget.isSend ? 'Verify Transaction' : 'Continue',
            onPressed: () {
              vm.saveTransaction(
                  adminID: widget.transaction.adminID,
                  transactionData: widget.transaction,
                  isSend: widget.isSend);
            },
          ),
        ),
      );
}
