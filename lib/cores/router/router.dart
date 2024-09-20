import 'package:go_router/go_router.dart';
import 'package:re_empties/cores/router/router_constant.dart';

late GoRouter _router;
GoRouter get router => _router;

setupRouter({required String initialRoute}) {
  _router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        name: paths.home,
        // builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: '/auth',
        name: paths.auth,
        // builder: (context, state) => const AuthView(),
      ),
      GoRoute(
        path: '/article',
        name: paths.article,
        // builder: (context, state) => const AuthView(),
      ),
    ],
    initialLocation: initialRoute,
  );
}
