import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:re_empties/cores/router/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Memastikan widget binding sudah siap
  await Firebase.initializeApp(); // Inisialisasi Firebase
  setupRouter(initialRoute: '/login'); // Setup router
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
    ScreenUtil.init(
      context,
      designSize: Size(375, 812), // Ganti dengan ukuran desain Anda
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return MaterialApp.router(
      title: 'Re-Empties',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
