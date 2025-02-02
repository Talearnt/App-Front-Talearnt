import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../constants/api_constants.dart';
import '../../utils/token_manager.dart';
import '../model/respone/failure.dart';
import '../model/respone/token.dart';
import 'authorization_interceptor.dart';

class DioService {
  final Dio _dio = Dio();
  final TokenManager _tokenManager;

  DioService(this._tokenManager,
      {required AuthorizationInterceptor interceptor}) {
    _dio.interceptors.add(interceptor);
  }

  Future<Either<Failure, dynamic>> get(String path, Map<String, dynamic>? data,
      Map<String, dynamic>? params) async {
    try {
      var response = await _dio.get(path, queryParameters: params, data: data);
      if (response.data is List) {
        return right(response.data as List<dynamic>);
      } else if (response.data is Map<String, dynamic>) {
        return right(response.data as Map<String, dynamic>);
      } else {
        // 알 수 없는 형태의 데이터
        return left(Failure(
          errorCode: 'UNEXPECTED_RESPONSE',
          errorMessage: 'Unexpected response format',
          success: false,
        ));
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        var result = await handleAuthResponse(e.response, () {
          return get(path, data, params);
        });
        return right(result.data as Map<String, dynamic>);
      }
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
      if (e.response?.statusCode == 401) {
        var result = await handleAuthResponse(e.response, () {
          return get(path, data, params);
        });
        return right(result.data as Map<String, dynamic>);
      }
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

  Future<Either<Failure, String>> put(String path, dynamic data,
      {int? size, String? contentType}) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        options: Options(
          headers: {
            if (size != null) 'Content-Length': size,
            if (contentType != null) 'Content-Type': contentType,
          },
        ),
      );

      return right(response.statusCode.toString());
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        var result = await handleAuthResponse(e.response, () {
          return put(path, data, size: size, contentType: contentType);
        });
        return right(result.statusCode.toString());
      }
      return left(Failure(
        data: e.response?.data,
        errorCode: e.response?.statusCode.toString() ?? 'DIO_ERROR',
        errorMessage: e.message ?? 'Unknown error occurred',
        success: false,
      ));
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

  Future handleAuthResponse(
      Response? response, Future<dynamic> Function() retryRequest) async {
    String errorCode = response?.data['errorCode'];
    if (errorCode == '401-AUTH-01') {
      await refreshTokenAndRetryRequest();
      return retryRequest();
    }
    return response?.data;
  }

  Future<void> refreshTokenAndRetryRequest() async {
    var result = await _dio.put(ApiConstants.refreshTokenUrl,
        data: _tokenManager.token!.toJson());
    _tokenManager.saveToken(Token.fromJson(result.data));
  }
}
