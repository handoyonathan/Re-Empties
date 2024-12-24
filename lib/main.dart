import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:re_empties/cores/router/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:re_empties/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Memastikan widget binding sudah siap
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Inisialisasi Firebase
  setupRouter(initialRoute: '/'); // Setup router
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi ScreenUtil di sini
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      // splitScreenMode: true,
      builder: (_, child) => ProviderScope(
        child: OKToast(
          child: MaterialApp.router(
            title: 'Re-Empties',
            routerConfig: router,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
