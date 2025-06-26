import 'package:app_front_talearnt/provider/auth/login_provider.dart';
import 'package:app_front_talearnt/provider/board/community_write_provider.dart';
import 'package:app_front_talearnt/provider/board/match_edit_provider.dart';
import 'package:dio/dio.dart';

import '../../provider/board/match_write_provider.dart';
import '../../provider/profile/profile_provider.dart';
import '../../utils/token_manager.dart';

class AuthorizationInterceptor extends InterceptorsWrapper {
  final TokenManager _tokenManager;
  final LoginProvider _loginProvider;
  final MatchWriteProvider _matchWriteProvider;
  final MatchEditProvider _matchEditProvider;
  final CommunityWriteProvider _communityWriteProvider;
  final ProfileProvider _profileProvider;

  AuthorizationInterceptor({
    required TokenManager tokenManager,
    required LoginProvider loginProvider,
    required MatchWriteProvider matchWriteProvider,
    required MatchEditProvider matchEditProvider,
    required CommunityWriteProvider communityWriteProvider,
    required ProfileProvider profileProvider,
  })  : _tokenManager = tokenManager,
        _loginProvider = loginProvider,
        _matchWriteProvider = matchWriteProvider,
        _matchEditProvider = matchEditProvider,
        _communityWriteProvider = communityWriteProvider,
        _profileProvider = profileProvider;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!_matchWriteProvider.isS3Upload &&
        !_matchEditProvider.isS3Upload &&
        !_communityWriteProvider.isS3Upload &&
        !_profileProvider.isS3Upload) {
      if (_loginProvider.isLoggedIn) {
        options.headers['authorization'] =
            'Bearer ${_tokenManager.token!.accessToken}';
      }

      options.headers['content-type'] = 'application/json';
      options.headers['X-Client-Path'] = 'mobile';
    }

    handler.next(options);
  }
}
