import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/provider_set_up.dart';
import 'package:app_front_talearnt/utils/routes.dart';
import 'package:flutter/material.dart';

import 'common/theme.dart';
import 'provider/provider_set_up.dart';
import 'utils/routes.dart';

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
    return MaterialApp.router(
      title: 'Talearnt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Pretendard",
        scaffoldBackgroundColor: Palette.bgBackGround,
      ),
      routerConfig: Routes.router,
    );
  }
}
