import 'package:app_front_talearnt/view_model/test_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/test_provider.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final testViewModel = Provider.of<TestViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MVVM with Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await testViewModel.fetchData();
              },
              child: const Text('Fetch Data'),
            ),
            const SizedBox(height: 20),
            Text(Provider.of<TestProvider>(context, listen: true).data),
          ],
        ),
      ),
    );
  }
}
