import 'package:app_front_talearnt/view/auth/widget/login_form.dart';
import 'package:app_front_talearnt/view/auth/widget/simple_login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../common/widget/loading.dart';
import '../../provider/common/common_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final commonProvider = Provider.of<CommonProvider>(context);
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.close))
          ]),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 52,
                ),
                SvgPicture.asset('assets/icons/no_rabbit_logo.svg'),
                const SizedBox(height: 54),
                Expanded(
                    child: ListView(
                  children: [
                    const SizedBox(height: 54),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      child: const LoginForm(),
                    ),
                    const SizedBox(height: 40.0),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: const SimpleLoginForm())
                  ],
                ))
              ],
            ),
          ),
          if (commonProvider.isLoadingPage) const Loading()
        ],
      ),
    );
  }
}
