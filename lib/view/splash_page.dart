import 'package:app_front_talearnt/provider/auth/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool hasNavigated = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final storageProvider =
          Provider.of<StorageProvider>(context, listen: false);
      storageProvider.setCooldownTime();
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (!hasNavigated) {
        hasNavigated = true;
        context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/img/splash_logo.svg'),
          ],
        ),
      ),
    );
  }
}
