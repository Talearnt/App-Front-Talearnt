import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../model/respone/failure.dart';

class DioService {
  final Dio _dio = Dio();

  Future<Either<Failure, Map<String, dynamic>>> get(String path,
      Map<String, dynamic>? data, Map<String, dynamic>? params) async {
    try {
      var response = await _dio.get(path, queryParameters: params, data: data);
      return right(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response?.data is Map<String, dynamic>) {
        final failureData = e.response!.data;
        return left(Failure.fromJson(failureData));
      } else {
        return left(Failure(
          errorCode: 'DIO_ERROR',
          errorMessage: e.message ?? 'Unknown error occurred',
          success: false,
        ));
      }
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> post(
      String path, dynamic data, Map<String, dynamic>? params) async {
    try {
      final response =
          await _dio.post(path, queryParameters: params, data: data);
      return right(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.response?.data is Map<String, dynamic>) {
        final failureData = e.response!.data;
        return left(Failure.fromJson(failureData));
      } else {
        return left(Failure(
          errorCode: 'DIO_ERROR',
          errorMessage: e.message ?? 'Unknown error occurred',
          success: false,
        ));
      }
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
