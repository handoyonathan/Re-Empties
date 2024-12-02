import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/custom_app_bar.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/components/tap_detector.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/send_empties/model/location_model.dart';
import 'package:re_empties/features/send_empties/viewModel/user_form_view_model.dart';
import 'package:re_empties/features/send_empties/widget/delivery_detail_container.dart';
import 'package:re_empties/features/send_empties/widget/stepper.dart';

class SendFormView extends ConsumerStatefulWidget {
  final Admin wasteLocation;
  final bool isSend;
  SendFormView({super.key, required this.wasteLocation, required this.isSend})
      : _viewModel =
            ChangeNotifierProvider.autoDispose<UserFormVM>(UserFormVM.new);

  final AutoDisposeChangeNotifierProvider<UserFormVM> _viewModel;

  @override
  ConsumerState createState() => SendFormState();
}

class SendFormState extends ConsumerState<SendFormView> {
  @override
  Widget build(BuildContext context) => BaseView(
        provider: widget._viewModel,
        appBar: (_) => CustomAppBar(
          title: Text(widget.isSend ? 'Send Form' : 'Drop Form',
              style: textTheme.appbarTitle),
        ),
        builder: _buildScreen,
      );

  Widget _buildScreen(BuildContext context, UserFormVM vm) => Scaffold(
        backgroundColor: colors.bgColor,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.isSend) ...[
                  Text(
                    'Delivery Detail',
                    style: textTheme.title,
                  ),
                  Gap(8.h),
                ],
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
                            name: widget.wasteLocation.stationName,
                            phoneNumber: widget.wasteLocation.adminPhone,
                            address: widget.wasteLocation.addressStation,
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
                        quantity: vm.wasteQuantities[category.id] ?? 0,
                        onIncrease: () => vm.increaseQuantity(category.id),
                        onDecrease: () => vm.decreaseQuantity(category.id),
                      ),
                      Gap(10.h),
                      Divider(color: colors.gray4, height: 1.h),
                      Gap(10.h),
                    ],
                  );
                }),
                if (widget.isSend) ...[
                  Gap(10.h),
                  Text(
                    'Delivery Options',
                    style: textTheme.title,
                  ),
                  TapDetector(
                    onTap: () => vm.showDeliveryOptions(),
                    child: Container(
                      height: 50.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                          color: colors.gray2,
                          borderRadius: BorderRadius.circular(15.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            vm.selectedDeliveryTitle,
                            style: textTheme.formName,
                          ),
                          RotatedBox(
                              quarterTurns: 2,
                              child: Icon(
                                Icons.arrow_back_ios_new_sharp,
                                color: colors.green1,
                                size: 20,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Gap(20.h),
                  Divider(
                    color: colors.gray4,
                    height: 1.h,
                  ),
                  Gap(20.h),
                  Text(
                    'Payment Options',
                    style: textTheme.title,
                  ),
                  TapDetector(
                    onTap: () => vm.showPaymentOptions(),
                    child: Container(
                      height: 50.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                          color: colors.gray2,
                          borderRadius: BorderRadius.circular(15.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(vm.selectedPaymentTitle,
                              style: textTheme.formName),
                          RotatedBox(
                              quarterTurns: 2,
                              child: Icon(
                                Icons.arrow_back_ios_new_sharp,
                                color: colors.green1,
                                size: 20,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
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
            text: 'Confirm',
            onPressed: () {
              vm.goToSuccessPage(
                  isSend: widget.isSend, wasteLocation: widget.wasteLocation);
            },
          ),
        ),
      );
}
