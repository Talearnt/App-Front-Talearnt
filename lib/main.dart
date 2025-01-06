import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/provider_set_up.dart';
import 'package:app_front_talearnt/utils/routes.dart';
import 'package:app_front_talearnt/view/splash_page.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const ProviderSetup(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talearnt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Pretendard",
        scaffoldBackgroundColor: Palette.bgBackGround,
      ),
      home: const SplashScreen(), // 스플래시 화면으로 시작
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Talearnt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Pretendard",
        scaffoldBackgroundColor: Palette.bgBackGround,
      ),
      routerConfig: Routes.router,
    );
  }
}
