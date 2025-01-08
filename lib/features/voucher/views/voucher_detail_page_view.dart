import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/hidden_app_bar.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/voucher/viewModel/voucher_detail_view_model.dart';

class VoucherDetailPageView extends StatefulWidget {
  final String voucherId;

  VoucherDetailPageView({super.key, required this.voucherId})
      : _viewModel = ChangeNotifierProvider.autoDispose((ref) =>
            VoucherDetailViewModel(ref, voucherId: voucherId)); // Constructor

  final AutoDisposeChangeNotifierProvider<VoucherDetailViewModel> _viewModel;

  @override
  State<VoucherDetailPageView> createState() => _VoucherDetailPageViewState();
}

class _VoucherDetailPageViewState extends State<VoucherDetailPageView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
        extendBodyBehindAppBar: true,
        disableSafeArea: true,
        provider: widget._viewModel,
        appBar: (_) => const HiddenAppBar(),
        builder: _buildScreen);
    // Build the UI for the voucher details
  }

  Widget _buildScreen(BuildContext context, VoucherDetailViewModel vm) {
    return Scaffold(
      backgroundColor: colors.background,
      body: !vm.isDataLoaded
          ? Center(
              child: CircularProgressIndicator(
                color: colors.green1,
                backgroundColor: colors.background,
              ),
            )
          : SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    Image.asset(
                      images.voucherCoffee,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 245.h,
                    ),
                    Positioned(
                      top: 60.0,
                      left: 16.0, 
                      child: GestureDetector(
                        onTap: () {
                          vm.backToList();
                        },
                        child: Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: colors.bgColor, 
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8.0,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: colors.green1,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ]),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vm.vouchers.title,
                          style: textTheme.title,
                        ),
                        Gap(4.h),
                        Text(
                          vm.vouchers.description,
                          style: textTheme.badgesText,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: colors.gray6,
                    height: 8.0.h,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TabBar(
                          controller: _tabController,
                          dividerColor: Colors.transparent,
                          indicatorColor: colors.textButton,
                          labelColor: colors.green1,
                          unselectedLabelColor: colors.gray5,
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter'),
                          tabs: const [
                            Tab(text: "How to Redeem"),
                            Tab(text: "Terms & Conditions"),
                          ],
                        ),
                        // Dynamically adjusting height based on content
                        SizedBox(
                          height: 125.h,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              // Terms & Conditions List

                              // How to Redeem List
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(top: 16),
                                itemCount: vm.vouchers.howToRedeem.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 2.0),
                                    child: Text(
                                      "${index + 1}. ${vm.vouchers.howToRedeem[index]}",
                                      style: textTheme.badgesText,
                                    ),
                                  );
                                },
                              ),

                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(top: 16),
                                itemCount:
                                    vm.vouchers.termsAndConditions.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 2.0),
                                    child: Text(
                                      "${index + 1}. ${vm.vouchers.termsAndConditions[index]}",
                                      style: textTheme.badgesText,
                                      textAlign: TextAlign.justify,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(20.h),
                  Container(
                    color: colors.gray6,
                    height: 8.h,
                    width: double.infinity,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Voucher Code',
                            style: textTheme.detailDropPointLabel,
                          ),
                          Text(
                            vm.vouchers.voucherCode,
                            style: textTheme.voucherCode,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: colors.gray6,
                    height: 8.h,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: colors.textButton,
                          size: 18.0,
                        ),
                        Gap(4.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Important Notes',
                                style: textTheme.subtitle2,
                              ),
                              Text(
                                  "Make sure to exchange your voucher at the cashier before pressing 'Complete' Once you press, the voucher will be claimed and you won't be able to access it again.",
                                  style: textTheme.badgesText,
                                  textAlign: TextAlign.justify),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(5.h),
                  Align(
                    alignment: Alignment.center,
                    child: AppMainButton(
                      state: ButtonState.primary,
                      text: 'Complete',
                      onPressed: () {
                        vm.useVoucher();
                        // print('Primary button pressed');
                      },
                    ),
                  ),
                  Gap(40.h)
                  // Add padding to avoid content being hidden by the button
                ],
              ),
            ),
    );
  }
}
