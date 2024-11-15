import 'package:app_front_talearnt/provider/auth/login_provider.dart';
import 'package:app_front_talearnt/provider/test_provider.dart';
import 'package:app_front_talearnt/view_model/test_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/repositories/test_repository.dart';
import 'common/common_provider.dart';

class ProviderSetup extends StatelessWidget {
  final Widget child;

  const ProviderSetup({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TestRepository>(
          create: (_) => TestRepository(),
        ),
        ChangeNotifierProvider<TestProvider>(
          create: (_) => TestProvider(),
        ),
        ChangeNotifierProvider<TestViewModel>(
          create: (context) => TestViewModel(
            Provider.of<TestProvider>(context, listen: false),
            Provider.of<TestRepository>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<CommonProvider>(create: (_) => CommonProvider()),
      ],
      child: child,
    );
  }
}
