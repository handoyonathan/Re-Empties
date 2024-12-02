import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/components/splash_screen.dart';
import 'package:re_empties/cores/components/success_page.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/features/admin/view/admin_profile.dart';
import 'package:re_empties/features/article/view/article_view.dart';
import 'package:re_empties/features/authentication/views/login_view.dart';
import 'package:re_empties/features/authentication/views/register_view.dart';
import 'package:re_empties/features/home/view/home_view.dart';
import 'package:re_empties/features/profile/view/edit_profile.dart';
import 'package:re_empties/features/profile/view/profile_view.dart';
// import 'package:re_empties/cores/components/test.dart';
import 'package:re_empties/cores/components/test.dart';
import 'package:re_empties/features/send_empties/model/location_model.dart';
import 'package:re_empties/features/send_empties/views/drop_point_detail_view.dart';
import 'package:re_empties/features/send_empties/views/user_form_view.dart';
import 'package:re_empties/features/send_empties/views/intro_page_view.dart';
import 'package:re_empties/features/send_empties/views/location_view.dart';

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
          path: '/admin',
          name: paths.admin,
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
          path: '/sendForm',
          name: paths.sendForm,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;

            return SendFormView(
              wasteLocation: extra['wasteLocation'] as Admin,
              isSend: extra['isSend'] ?? false,
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
              isSend: extra['isSend'] ?? false,
            );
          }),
    ],
    initialLocation: initialRoute,
  );
}
