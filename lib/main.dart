import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/data/services/local_notification_service.dart';
import 'package:app_front_talearnt/data/services/notification_permission_service.dart';
import 'package:app_front_talearnt/firebase_options.dart';
import 'package:app_front_talearnt/provider/provider_set_up.dart';
import 'package:app_front_talearnt/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationPermissionService.ensurePermission();
  await LocalNotificationService.I.init();
  runApp(const ProviderSetup(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Talearnt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Pretendard',
        scaffoldBackgroundColor: Palette.bgBackGround,
      ),
      routerConfig: Routes.router,
    );
  }
}
