import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:re_empties/cores/components/article_preview_home.dart';
import 'package:re_empties/cores/components/banner_home.dart';
import 'package:re_empties/cores/components/hidden_app_bar.dart';
import 'package:re_empties/cores/components/points_card_home.dart';
import 'package:re_empties/cores/components/send_drop_card.dart';
import 'package:re_empties/cores/components/status_preview_home.dart';
import 'package:re_empties/cores/constant/colors.dart';
import 'package:re_empties/cores/constant/text_theme.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/home/view%20model/dashboard_viewmodel.dart'; // Pastikan import sesuai dengan kebutuhan

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView>
    with SingleTickerProviderStateMixin {
  late AutoDisposeChangeNotifierProvider<DashboardVM> viewModel;

  @override
  void initState() {
    viewModel = ChangeNotifierProvider.autoDispose(DashboardVM.new);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dashboardVM = ref.read(viewModel);
      dashboardVM.checkLoginStatus(context);
      // dashboardVM.fetchUserTransactionData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      extendBodyBehindAppBar: true,
      disableSafeArea: true,
      provider: viewModel,
      builder: (context, vm) => _buildScreen(context, vm),
      appBar: (_) => const HiddenAppBar(),
    );
  }

  Widget _buildScreen(BuildContext context, DashboardVM vm) {
    final transaction = vm.transactions;
    final admin = vm.adminData;

    return Scaffold(
      backgroundColor: colors.bgColor,
      body: !vm.isDataLoaded
          ? Center(
              child: CircularProgressIndicator(
              color: colors.green2,
            ))
          : SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  BannerHome(
                    totalPoints: vm.totalPoints,
                    availablePoints: vm.point,
                    level: 5,
                    isProfilePage: false,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.h),
                    child: Column(
                      children: [
                        // Gap(10.h),
                        HomePointsCard(
                          onTap: () {
                            vm.goToVoucherPage();
                            print("points");
                          },
                          points: vm.point,
                        ),
                        Gap(10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            HomeSendDropCard(
                              state: SendDropState.drop,
                              onTap: () {
                                vm.goToIntroPage();
                              },
                            ),
                            HomeSendDropCard(
                              state: SendDropState.send,
                              onTap: () {
                                vm.goToIntroPage(isSend: true);
                              },
                            ),
                          ],
                        ),
                        Gap(10.h),
                        Visibility(
                          visible: transaction != null &&
                              admin !=
                                  null, // Menampilkan hanya jika data tersedia
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              StatusPreviewHome(
                                state: transaction?.transactionType ??
                                    'Unknown', // Amankan null
                                dateTime:
                                    '${vm.firstTransactionDate} ${vm.firstTransactionTime}', // Amankan null
                                wasteStation: admin?.stationName ??
                                    'Unknown', // Amankan null
                                onTap: () {
                                  print("Card tapped!");
                                  vm.gotoDetail();
                                },
                              ),
                            ],
                          ),
                        ),
                        Gap(10.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Articles",
                            style: textTheme.title,
                          ),
                        ),
                        ArticlePreviewHome(),
                        Gap(30.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
