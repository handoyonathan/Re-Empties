import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/components/splash_screen.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/features/admin/view/admin_profile.dart';
import 'package:re_empties/features/authentication/views/login_view.dart';
import 'package:re_empties/features/authentication/views/register_view.dart';
import 'package:re_empties/features/home/view/home_view.dart';
import 'package:re_empties/features/profile/view/edit_profile.dart';
import 'package:re_empties/features/profile/view/profile_view.dart';
// import 'package:re_empties/cores/components/test.dart';

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
        path: '/edit-profile/:fullName/:email/:phoneNumber',
        name: paths.editProfile,
        builder: (context, state) {
          final fullName = state.pathParameters['fullName']!;
          final email = state.pathParameters['email']!;
          final phoneNumber = state.pathParameters['phoneNumber']!;
          return EditProfileView(
            fullName: fullName,
            email: email,
            phoneNumber: phoneNumber,
          );
        },
      ),
    ],
    initialLocation: initialRoute,
  );
}
