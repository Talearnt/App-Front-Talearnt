import 'package:dio/dio.dart';

class DioService {
  final Dio _dio = Dio();

  Future<Response> get(String path, Map<String, dynamic>? params) async {
    try {
      //queryParameters로 안하고 data로 진행해도 될거같긴한데 일단 해놓음
      var response = await _dio.get(path, queryParameters: params ?? {});
      return response.data ?? {};
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> post(String path, dynamic data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> put(String path, dynamic data) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
