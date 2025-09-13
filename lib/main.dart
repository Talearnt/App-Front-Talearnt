import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/data/services/local_notification_service.dart';
import 'package:app_front_talearnt/data/services/notification_permission_service.dart';
import 'package:app_front_talearnt/firebase_options.dart';
import 'package:app_front_talearnt/provider/notification/notification_provider.dart';
import 'package:app_front_talearnt/provider/provider_set_up.dart';
import 'package:app_front_talearnt/provider/termination/termination_provider.dart';
import 'package:app_front_talearnt/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
bool _fcmStarted = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  final String nativeAppKey = dotenv.env['NATIVE_APP_KEY'] ?? '';
  KakaoSdk.init(nativeAppKey: nativeAppKey);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationPermissionService.ensurePermission();
  await LocalNotificationService.I.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TerminationProvider()),
      ],
      child: ProviderSetup(
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    if (!_fcmStarted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_fcmStarted) return;
        _fcmStarted = true;
        context.read<NotificationProvider>().startFCM();
      });
    }
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
