import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      dashboardVM.checkLoginStatus(context); // Check login status on load
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      extendBodyBehindAppBar: true,
      disableSafeArea: true,
      provider: viewModel,
      builder: (context, vm) => _buildScreen(context, vm),
      appBar: (_) => HiddenAppBar(),
    );
  }

  Widget _buildScreen(BuildContext context, DashboardVM vm) => Scaffold(
        backgroundColor: colors.bgColor,
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              // Banner that covers the top part of the screen
              BannerHome(
                level: 1,
                isProfilePage: false,
              ),

              // Positioned content starting below the banner with a gap of 18.h
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    HomePointsCard(onTap: () {
                      print("points");
                    }),
                    const SizedBox(height: 10),
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
                    Visibility(
                      visible: true, // nanti diganti, diatur dari vm
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          StatusPreviewHome(
                            state: "send", // or "drop"
                            dateTime: "Monday, 21/12/24 21:30",
                            wasteStation: "Green Valley Recycling Center",
                            onTap: () {
                              print("Card tapped!");
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Articles",
                        style: textTheme.title,
                      ),
                    ),
                    ArticlePreviewHome(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
