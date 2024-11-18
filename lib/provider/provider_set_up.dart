import 'package:app_front_talearnt/provider/auth/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/common_provider.dart';

class ProviderSetup extends StatelessWidget {
  final Widget child;

  const ProviderSetup({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<CommonProvider>(create: (_) => CommonProvider()),
      ],
      child: child,
    );
  }
}
