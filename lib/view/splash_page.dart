import 'package:app_front_talearnt/main.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:app_front_talearnt/provider/auth/storage_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storageProvider = Provider.of<StorageProvider>(context);
    storageProvider.setCooldownTime();

    return AnimatedSplashScreen(
      splash: SvgPicture.asset(
        'assets/img/splash_logo.svg',
      ),
      nextScreen: const MainApp(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white,
      duration: 3000,
    );
  }
}
