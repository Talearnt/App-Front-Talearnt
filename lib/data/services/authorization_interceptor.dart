import 'package:app_front_talearnt/provider/auth/login_provider.dart';
import 'package:dio/dio.dart';

import '../../utils/token_manager.dart';

class AuthorizationInterceptor extends InterceptorsWrapper {
  final TokenManager _tokenManager;
  final LoginProvider _loginProvider;

  AuthorizationInterceptor({
    required TokenManager tokenManager,
    required LoginProvider loginProvider,
  })  : _tokenManager = tokenManager,
        _loginProvider = loginProvider;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_loginProvider.isLoggedIn) {
      options.headers['authorization'] =
          'Bearer ${_tokenManager.token!.accessToken}';
    }
    options.headers['content-type'] = 'application/json';
    handler.next(options);
  }
}
