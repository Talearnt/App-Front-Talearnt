import 'package:app_front_talearnt/view/auth/widget/login_form.dart';
import 'package:app_front_talearnt/view/auth/widget/simple_login_form.dart';
import 'package:app_front_talearnt/view/talearnt_board/match_write1_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const MatchWrite1Page();
                    },
                  ));
                },
                icon: const Icon(Icons.close))
          ]),
      body: Center(
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
    );
  }
}
