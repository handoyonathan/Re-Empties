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
import 'package:re_empties/features/admin/widget/filter_button.dart';
import 'package:re_empties/features/order/viewmodel/order_history_viewmodel.dart';
import 'package:re_empties/features/send_empties/model/transaction_model.dart';

class OrderHistoryView extends StatelessWidget {
  final AutoDisposeChangeNotifierProvider<OrderHistoryVM> _viewModel;

  OrderHistoryView({super.key})
      : _viewModel = ChangeNotifierProvider.autoDispose<OrderHistoryVM>(
          OrderHistoryVM.new);

  @override
  Widget build(BuildContext context) => BaseView<OrderHistoryVM>(
        provider: _viewModel,
        appBar: (_) => CustomAppBar(
          showLeading: false,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Orders History',
              style: textTheme.title,
            ),
          ),
          backgroundColor: colors.bgColor,
        ),
        builder: _buildScreen,
        disableSafeArea: false,
      );

  Widget _buildScreen(BuildContext context, OrderHistoryVM vm) =>
      DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: colors.bgColor,
          appBar: TabBar(
            overlayColor: WidgetStateColor.transparent,
            dividerColor: Colors.transparent,
            labelColor: colors.green1,
            unselectedLabelColor: colors.gray3,
            indicatorColor: colors.green1,
            onTap: (index) {
              final tabs = ['All', 'Delivery', 'Canceled', 'Verify'];
              vm.setTab(tabs[index]);
            },
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Ongoing'),
              Tab(text: 'Canceled'),
              Tab(text: 'Done'),
            ],
          ),
          body: vm.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: colors.green2,
                ))
              : _buildOrderList(vm.filteredTransactions, vm),
        ),
      );

  Widget _buildOrderList(List<TransactionModel> orders, OrderHistoryVM vm) {
    return Column(
      children: [
        Gap(20.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FilterButton(
                label: 'All',
                isSelected: vm.selectedFilter == 'All',
                onTap: () => vm.setFilter('All'),
              ),
              Gap(8.w),
              FilterButton(
                label: 'Send Empties',
                isSelected: vm.selectedFilter == 'Send',
                onTap: () => vm.setFilter('Send'),
              ),
              Gap(8.w),
              FilterButton(
                label: 'Drop Empties',
                isSelected: vm.selectedFilter == 'Drop',
                onTap: () => vm.setFilter('Drop'),
              ),
            ],
          ),
        ),
        Gap(8.h),
        Expanded(
          child: !vm.isDataLoaded
              ? Center(child: CircularProgressIndicator(color: colors.green2))
              : orders.isEmpty
                  ? Center(
                      child: Text(
                        'No history',
                        style:
                            textTheme.appbarTitle.copyWith(color: colors.gray3),
                      ),
                    )
                  : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        final date = vm.transactionDates[order.transactionId] ?? '';
                        final time = vm.transactionTimes[order.transactionId] ?? '';
                        bool isCanceled = order.orderStatus == 'Canceled';

                        return TapDetector(
                          onTap: () {
                            vm.gotoDetail(index);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 15.w),
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: isCanceled ? colors.gray2 : colors.yellow4,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            date,
                                            style: textTheme.orderHistory,
                                          ),
                                          Text(
                                            time,
                                            style: textTheme.orderHistory,
                                          ),
                                        ],
                                      ),
                                      Gap(10.h),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8.w),
                                            width: 60.w,
                                            height: 60.h,
                                            decoration: BoxDecoration(
                                              color: colors.green4,
                                              shape: BoxShape.circle,
                                            ),
                                            child: ImageAsset(
                                              imagePath:
                                                  order.transactionType ==
                                                          'Drop'
                                                      ? images.dropWaste
                                                      : images.sendWaste,
                                            ),
                                          ),
                                          Gap(10.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  vm.adminData[index]
                                                      .stationName,
                                                  style: textTheme
                                                      .orderStationName,
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Gap(2.h),
                                                isCanceled
                                                    ? Row(
                                                        children: [
                                                          ImageAsset(
                                                            imagePath:
                                                                images.cancel,
                                                            width: 15.w,
                                                            height: 15.h,
                                                          ),
                                                          Gap(5.w),
                                                          Text(
                                                            'Order Canceled',
                                                            style: textTheme
                                                                .homeShipLabel1,
                                                          ),
                                                        ],
                                                      )
                                                    : Text(
                                                        '${order.totalWastePcs} pcs',
                                                        style: textTheme
                                                            .successPointLabel,
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }
}