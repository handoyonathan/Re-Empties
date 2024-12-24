import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/components/custom_app_bar.dart';
import 'package:re_empties/cores/components/custom_sheet_voucher.dart';
import 'package:re_empties/cores/components/points_card_reedem.dart';
import 'package:re_empties/cores/components/voucher_card_reedem.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/voucher/viewModel/voucher_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/button_main_app.dart';
import 'package:re_empties/cores/components/image_asset.dart';
import 'package:re_empties/cores/constant/image_path.dart';

class VoucherPageView extends ConsumerWidget {
  VoucherPageView({super.key})
      : _viewModel = ChangeNotifierProvider.autoDispose<VoucherViewModel>(
            VoucherViewModel.new);

  final AutoDisposeChangeNotifierProvider<VoucherViewModel> _viewModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseView(
        provider: _viewModel,
        disableSafeArea: true,
        appBar: (_) => CustomAppBar(
              title: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Vouchers',
                  style: textTheme.appbarTitle,
                ),
              ),
            ),
        builder: _buildScreen);
  }

  Widget _buildScreen(BuildContext context, VoucherViewModel vm) {
    return Scaffold(
      backgroundColor: colors.background,
      body: vm.isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: colors.green1, backgroundColor: colors.background))
          : vm.vouchers.isEmpty
              ? Center(
                  child: ImageAsset(
                  imagePath: images.errorIllustration,
                  height: 550.h,
                  width: 250.w,
                ))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    physics:  const ClampingScrollPhysics(),
                    // Wrap the entire content in a SingleChildScrollView
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // "Recycle points" text
                        Text('Recycle points', style: textTheme.title),
                        Gap(8.h), // RedeemPointsCard component
                        ReedemPointsCard(points: vm.point.toString()),
                        Gap(24.h), // Spacer between sections
                        // "Vouchers" text
                        Text('Vouchers', style: textTheme.title),
                        Gap(8.h),
                        // Spacer between title and list
                        // List of VoucherCardRedeem components
                        ListView.builder(
                          shrinkWrap: true,
                          physics:
                              const ClampingScrollPhysics(), // This ensures the list is not taking full height
                          itemCount: vm.vouchers.length,
                          itemBuilder: (context, index) {
                            final voucher = vm.vouchers[index];
                            return VoucherCardRedeem(
                              isOutOfStock: vm.isVoucherOutOfStock(voucher),
                              isUsed: vm.isVoucherUsed(voucher),
                              category: voucher.category,
                              title: voucher.title,
                              description: voucher.description,
                              points: voucher.points,
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomSheetVoucher(
                                      title: voucher.title,
                                      description: voucher.description,
                                      points: voucher.points,
                                      category: voucher.category,
                                      onTap: () {
                                        vm.goToDetailVoucher(index);
                                        // print(vm.selectedVoucher?.title);
                                        // ctx.pushNamed(
                                        //   'voucherDetail', // Ensure this matches your GoRouter path name
                                        // );
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
