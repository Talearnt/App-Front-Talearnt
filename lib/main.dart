import 'package:app_front_talearnt/common/theme.dart';
import 'package:app_front_talearnt/provider/provider_set_up.dart';
import 'package:app_front_talearnt/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //이건 웹이라서 나중에 피료없을수도
  await dotenv.load(fileName: "assets/.env");
  String nativeAppKey = dotenv.env['NATIVE_APP_KEY'] ?? '';

  // Kakao SDK 초기화
  KakaoSdk.init(nativeAppKey: nativeAppKey);

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
