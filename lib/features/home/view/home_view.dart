import 'package:flutter/material.dart';
import 'package:re_empties/cores/components/hidden_app_bar.dart';
import 'package:re_empties/cores/components/navbar/bottom_navbar.dart';
import 'package:re_empties/cores/components/navbar/navbar_model.dart';
import 'package:re_empties/cores/constant/image_path.dart';
import 'package:re_empties/cores/template/view.dart';
import 'package:re_empties/features/admin/view/admin_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:re_empties/features/home/view%20model/home_view_model.dart';
import 'package:re_empties/features/home/view/dashboard_view.dart';
import 'package:re_empties/features/order/view/order_history_view.dart';
import 'package:re_empties/features/profile/view/profile_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with SingleTickerProviderStateMixin {
  late AutoDisposeChangeNotifierProvider<HomeVM> viewModel;
  List<NavBarModel> _tabViewList = [];

  @override
  void initState() {
    _tabViewList = [
      NavBarModel(
        widget: DashboardView(),
        icon: images.homeTab,
      ),
      NavBarModel(
        widget: OrderHistoryView(),
        icon: images.transactionTab,
      ),
      NavBarModel(
        widget: ProfileView(),
        icon: images.profileTab,
      ),
    ];
    viewModel = ChangeNotifierProvider.autoDispose(HomeVM.new);
    ref.read(viewModel).setController(length: _tabViewList.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: false,
        child: BaseView(
          provider: viewModel,
          builder: _buildScreen,
          appBar: (_) => const HiddenAppBar(
            backgroundColor: Colors.transparent,
          ),
          extendBodyBehindAppBar: true,
          disableSafeArea: true,
        ),
      );

  Widget _buildScreen(BuildContext context, HomeVM vm) => Scaffold(
        bottomNavigationBar: BottomNavBar(
          tabList: _tabViewList,
          selectedIndex: vm.selectedIndex,
          setIndex: vm.selectIndex,
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: vm.controller,
          children: _tabViewList.map((tabModel) => tabModel.widget).toList(),
        ),
      );
}
