import 'package:dio/dio.dart';
import 'package:mustore/core/config/api_config.dart';
import 'package:mustore/core/network/api/api_guard.dart';
import 'package:mustore/core/network/http/http_header_keys.dart';
import 'package:mustore/features/auth/data/data_sources/local/session_storage.dart';
import 'package:mustore/features/auth/data/models/auth_session_model.dart';
import 'package:mustore/features/auth/domain/events/session_event.dart';
import 'package:mustore/features/auth/domain/params/refresh_token_params.dart';
import 'package:mustore/features/auth/domain/params/revoke_session_params.dart';

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required SessionStorage sessionStorage,
    required SessionEvents sessionEvents,
    required Set<String> publicPaths,
    required String refreshPath,
    required String revokePath,
  })  : _sessions = sessionStorage,
        _events = sessionEvents,
        _publicPaths = publicPaths,
        _refreshPath = refreshPath,
        _revokePath = revokePath,
        _host = Uri.parse(ApiConfig.baseUrl).host,
        _dio = Dio(BaseOptions(
          baseUrl: ApiConfig.baseUrl,
          connectTimeout: ApiConfig.connectTimeout,
          receiveTimeout: ApiConfig.receiveTimeout,
        ));

  final SessionStorage _sessions;
  final SessionEvents _events;
  final Set<String> _publicPaths;
  final String _refreshPath;
  final String _revokePath;
  final String _host;
  final Dio _dio;

  bool _isProtected(RequestOptions o) =>
      !_publicPaths.contains(o.path) && o.uri.host == _host;

  String _bearer(String token) => '${HeaderKeys.bearer} $token';

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    if (_isProtected(options)) {
      final session = await _sessions.read();
      if (session != null) {
        options.headers[HeaderKeys.authorization] =
            _bearer(session.accessToken);
      }
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    final req = err.requestOptions;
    if (!err.isUnauthorized || !_isProtected(req)) {
      return handler.next(err);
    }

    final session = await _sessions.read();
    if (session == null) {
      _events.add(SessionEvent.expired);
      return handler.next(err);
    }

    if (req.headers[HeaderKeys.authorization] != _bearer(session.accessToken)) {
      return _retry(req, session.accessToken, handler);
    }

    final refreshed = await guardApiCall<AuthSessionModel>(() async {
      final response = await _dio.post(
        _refreshPath,
        data: RefreshTokenParams(refreshToken: session.refreshToken).toJson(),
      );
      final fresh =
      AuthSessionModel.fromJson(response.data as Map<String, dynamic>);
      await _sessions.save(fresh);
      return fresh;
    });

    await refreshed.fold<Future<void>>(
          (failure) async {
        if (failure.isUnauthorized) {
          await _expire(session.refreshToken);
          return handler.next(err);
        }
        handler.next(failure.toDioException(req));
      },
          (fresh) async {
        _events.add(SessionEvent.refreshed);
        await _retry(req, fresh.accessToken, handler);
      },
    );
  }

  Future<void> _retry(
      RequestOptions req,
      String accessToken,
      ErrorInterceptorHandler handler,
      ) async {
    req.headers[HeaderKeys.authorization] = _bearer(accessToken);

    if (req.data is FormData) {
      req.data = (req.data as FormData).clone();
      req.headers.remove(HeaderKeys.contentType);
      req.contentType = null;
    }

    final result = await guardApiCall<Response<dynamic>>(() => _dio.fetch(req));
    result.fold(
          (failure) => handler.next(failure.toDioException(req)),
      handler.resolve,
    );
  }

  Future<void> _expire(String refreshToken) async {
    await guardApiCall<Response<dynamic>>(
          () => _dio.post(
        _revokePath,
        data: RevokeSessionParams(refreshToken: refreshToken).toJson(),
      ),
    );
    await _sessions.clear();
    _events.add(SessionEvent.expired);
  }
}