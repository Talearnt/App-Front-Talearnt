import 'package:app_front_talearnt/data/services/dio_service.dart';

class TestRepository {
  final DioService dio = DioService();

  String getData() {
    //원래 url 던지기 때문에 이렇게 정의해야되는데 이건 테스트라서 future가 안들어갑니다.
    // Future<int> getData() {
    // var result = dio.get('https://example.com', null);
    var result = '1';
    return result;
  }
}
