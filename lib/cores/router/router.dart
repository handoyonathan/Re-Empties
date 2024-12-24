import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:re_empties/features/send_empties/views/countdown_view.dart';
import 'package:re_empties/cores/components/splash_screen.dart';
import 'package:re_empties/cores/components/success_page.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/features/admin/view/admin_profile.dart';
import 'package:re_empties/features/admin/view/admin_view.dart';
import 'package:re_empties/features/admin/view/fill_order_id.view.dart';
import 'package:re_empties/features/admin/view/transaction_detail_view.dart';
import 'package:re_empties/features/article/view/article_view.dart';
import 'package:re_empties/features/authentication/views/login_view.dart';
import 'package:re_empties/features/authentication/views/register_view.dart';
import 'package:re_empties/features/home/view/home_view.dart';
import 'package:re_empties/features/order/view/order_history_view.dart';
import 'package:re_empties/features/order/view/order_summary_view.dart';
import 'package:re_empties/features/profile/view/edit_profile.dart';
import 'package:re_empties/features/profile/view/profile_view.dart';
// import 'package:re_empties/cores/components/test.dart';
import 'package:re_empties/cores/components/test.dart';
import 'package:re_empties/features/send_empties/model/location_model.dart';
import 'package:re_empties/features/send_empties/views/drop_point_detail_view.dart';
import 'package:re_empties/features/send_empties/views/user_form_view.dart';
import 'package:re_empties/features/send_empties/views/intro_page_view.dart';
import 'package:re_empties/features/send_empties/views/location_view.dart';
import 'package:re_empties/features/voucher/model/voucher_model.dart';
import 'package:re_empties/features/voucher/viewModel/voucher_view_model.dart';
import 'package:re_empties/features/voucher/views/voucher_detail_page_view.dart';
import 'package:re_empties/features/voucher/views/voucher_page_view.dart';

late GoRouter _router;
GoRouter get router => _router;

setupRouter({required String initialRoute}) {
  _router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        name: paths.splash,
        builder: (context, state) =>
            const SplashScreen(), // Tambahkan builder untuk halaman utama
      ),
      GoRoute(
        path: '/test',
        name: paths.test,
        builder: (context, state) =>
            VoucherPageView(), // Tambahkan builder untuk halaman utama
      ),
      GoRoute(
        path: '/home',
        name: paths.home,
        builder: (context, state) =>
            const HomeView(), // Tambahkan builder untuk halaman utama
      ),
      GoRoute(
          path: '/login',
          name: paths.login,
          builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/register',
        name: paths.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
          path: '/adminView',
          name: paths.adminView,
          builder: (context, state) => AdminView()),
      GoRoute(
          path: '/adminProfile',
          name: paths.adminProfile,
          builder: (context, state) => AdminProfile()),
      GoRoute(
          path: '/profile',
          name: paths.profile,
          builder: (context, state) => ProfileView()),
      GoRoute(
        path: '/editProfile',
        name: paths.editProfile,
        builder: (context, state) {
          final extra = state.extra as Map<String, String?>;

          return EditProfileView(
              fullName: extra['fullName']!,
              email: extra['email']!,
              phoneNumber: extra['phoneNumber']!);
        },
      ),
      GoRoute(
          path: '/success',
          name: paths.success,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;

            return SuccessPage(
              isAdmin: extra['isAdmin'] ?? false,
              point: extra['point'],
              isSend: extra['isSend'] ?? false,
            );
          }),
      GoRoute(
          path: '/countDown',
          name: paths.countDown,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;

            return CountdownView(
              transactionId: extra['transactionId'],
              point: extra['point'],
            );
          }),
      GoRoute(
          path: '/location',
          name: paths.location,
          builder: (context, state) => LocationView(
                isSend: state.extra as bool? ?? false,
              )),
      GoRoute(
          path: '/intro',
          name: paths.intro,
          builder: (context, state) => IntroView(
                isSend: state.extra as bool? ?? false,
              )),
      GoRoute(
          path: '/fillDropID',
          name: paths.fillDropID,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;

            return FillOrderID(
              adminID: extra['adminID'],
              transactionData: extra['transactionData'],
              point: extra['point'],
              weight: extra['weight'],
              plasticWeight: extra['plasticWeight'],
              cardboardWeight: extra['cardboardWeight'],
              glassWeight: extra['glassWeight'],
            );
          }),
      GoRoute(
          path: '/sendForm',
          name: paths.sendForm,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;

            return SendFormView(
              wasteLocation: extra['wasteLocation'] as Admin,
              isSend: extra['isSend'] ?? false,
              currentLocation: extra['currentLocation'] as LatLng,
            );
          }),
      GoRoute(
          path: '/article',
          name: paths.article,
          builder: (context, state) => ArticleView(
                articleId: state.extra as String,
              )),
      GoRoute(
          path: '/dropPointDetail',
          name: paths.dropPointDetail,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;

            return DropPointDetailView(
              wasteLocation: extra['wasteLocation'] as Admin,
              dropID: extra['dropID'],
              transactionId: extra['transactionID'],
              // isSend: extra['isSend'] ?? false,
              // transactionIdAdmin: extra['transactionIDAdmin'],
              // transactionIdUser: extra['transactionIDUser'],
            );
          }),
      GoRoute(
          path: '/transactionDetail',
          name: paths.transactionDetail,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;

            return TransactionDetailView(
              isSend: extra['isSend'] ?? false,
              transactionID: extra['transactionID'],
              transaction: extra['transaction'],
            );
          }),
      GoRoute(
        path: '/transactionHistory',
        name: paths.transactionHistory,
        builder: (context, state) => OrderHistoryView(),
      ),
      GoRoute(
        path: '/transactionHistoryDetail',
        name: paths.transactionHistoryDetail,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return OrderSummaryView(
            transactionID: extra['transactionID'],
          );
        },
      ),
      GoRoute(
        path: '/voucher',
        name: paths.voucher,
        builder: (context, state) =>
            VoucherPageView(),
      ),
      GoRoute(
        path: '/voucherDetail',
        name: 'voucherDetail',
        builder: (context, state) {
          return VoucherDetailPageView(
            voucherId: state.extra as String,
          );
        },
      )
    ],
    initialLocation: initialRoute,
  );
}
