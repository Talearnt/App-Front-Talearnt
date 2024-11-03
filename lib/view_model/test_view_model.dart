import 'package:app_front_talearnt/data/repositories/test_repository.dart';
import 'package:app_front_talearnt/provider/test_provider.dart';
import 'package:flutter/material.dart';

class TestViewModel extends ChangeNotifier {
  final TestProvider testProvider;
  final TestRepository testRepository;

  TestViewModel(this.testProvider, this.testRepository);

  // API 데이터 요청을 시뮬레이션하는 메서드
  Future<void> fetchData() async {
    // await testRepository.getData();
    var result = testRepository.getData();
    testProvider.fetchData(result);
  }
}
