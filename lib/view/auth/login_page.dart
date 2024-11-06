import 'package:app_front_talearnt/view/auth/widget/login_form.dart';
import 'package:app_front_talearnt/view/auth/widget/simple_login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.close))
          ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 52,
            ),
            Image.asset('assets/img/no_rabbit_logo.png'),
            const SizedBox(height: 54),
            Expanded(
                child: ListView(
              children: [
                const SizedBox(height: 54),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: LoginForm(),
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
    );
  }
}
