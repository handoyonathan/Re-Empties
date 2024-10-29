import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/components/success_page.dart';
import 'package:re_empties/cores/router/router_constant.dart';
import 'package:re_empties/features/authentication/views/login_view.dart';
import 'package:re_empties/features/authentication/views/register_view.dart';
import 'package:re_empties/features/home/view/home_view.dart';
import 'package:re_empties/cores/components/test.dart';
import 'package:re_empties/features/send_empties/views/form_send_view.dart';

late GoRouter _router;
GoRouter get router => _router;

setupRouter({required String initialRoute}) {
  _router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        name: paths.home,
        builder: (context, state) =>
            const HomeView(), // Tambahkan builder untuk halaman utama
      ),
      GoRoute(
        path: '/login',
        name: paths.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: paths.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/success',
        name: paths.success,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final isDrop = extra['isDrop'];
          final points = extra['points'];

          return SuccessPage(isDrop: isDrop, points: points);
        },
      ),
      GoRoute(
          path: '/test',
          name: paths.test,
          builder: (context, state) => const TestWidget()),
    ],
    initialLocation: initialRoute,
  );
}
