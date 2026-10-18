import 'package:dio/dio.dart';
import 'package:mustore/core/config/api_config.dart';
import 'package:mustore/core/network/api/api_client.dart';
import 'package:mustore/core/network/http/http_header_keys.dart';
import 'package:mustore/core/network/http/http_method.dart';

class DioApiClient implements ApiClient {
  late final Dio _dio;

  DioApiClient({
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Map<String, dynamic>? headers,
    List<Interceptor> interceptors = const [],
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: connectTimeout ?? ApiConfig.connectTimeout,
        receiveTimeout: receiveTimeout ?? ApiConfig.receiveTimeout,
        headers: headers ??
            {HeaderKeys.contentType: HeaderKeys.applicationJson},
      ),
    );
    _dio.interceptors.addAll(interceptors);
  }

  @override
  void setAuthToken(String token) => _dio.options.headers[
  HeaderKeys.authorization] = '${HeaderKeys.bearer} $token';

  @override
  void clearAuthToken() =>
      _dio.options.headers.remove(HeaderKeys.authorization);

  String _url(String? baseUrl, String path) =>
      (baseUrl != null && baseUrl != ApiConfig.baseUrl)
          ? '$baseUrl$path'
          : path;

  Future<Response> _send(
      HttpMethod method, {
        required String path,
        String? baseUrl,
        Object? data,
        Map<String, dynamic>? query,
        Map<String, dynamic>? headers,
        bool multipart = false,
      }) {
    final body = multipart ? _toFormData(data) : data;

    return _dio.request(
      _url(baseUrl, path),
      data: body,
      queryParameters: query,
      options: Options(
        method: method.value,
        headers: headers,
        contentType: multipart ? HeaderKeys.multipartFormData : null,
      ),
    );
  }

  @override
  Future<Response> get({
    required String path,
    String? baseUrl = ApiConfig.baseUrl,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) =>
      _send(HttpMethod.get,
          path: path, baseUrl: baseUrl, query: query, headers: headers);

  @override
  Future<Response> post({
    required String path,
    String? baseUrl = ApiConfig.baseUrl,
    Object? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    bool multipart = false,
  }) =>
      _send(HttpMethod.post,
          path: path,
          baseUrl: baseUrl,
          data: data,
          query: query,
          headers: headers,
          multipart: multipart);

  @override
  Future<Response> put({
    required String path,
    String? baseUrl = ApiConfig.baseUrl,
    Object? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    bool multipart = false,
  }) =>
      _send(HttpMethod.put,
          path: path,
          baseUrl: baseUrl,
          data: data,
          query: query,
          headers: headers,
          multipart: multipart);

  @override
  Future<Response> patch({
    required String path,
    String? baseUrl = ApiConfig.baseUrl,
    Object? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    bool multipart = false,
  }) =>
      _send(HttpMethod.patch,
          path: path,
          baseUrl: baseUrl,
          data: data,
          query: query,
          headers: headers,
          multipart: multipart);

  @override
  Future<Response> delete({
    required String path,
    String? baseUrl = ApiConfig.baseUrl,
    Object? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) =>
      _send(HttpMethod.delete,
          path: path,
          baseUrl: baseUrl,
          data: data,
          query: query,
          headers: headers);

  FormData _toFormData(Object? data) {
    if (data is FormData) return data;
    final form = FormData();
    _addFields(form, '', data);
    return form;
  }

  void _addFields(FormData form, String prefix, dynamic value) {
    if (value == null) return;
    if (value is Map<String, dynamic>) {
      value.forEach(
            (k, v) => _addFields(form, prefix.isEmpty ? k : '$prefix.$k', v),
      );
    } else if (value is List) {
      if (value.isNotEmpty && value.first is MultipartFile) {
        for (final f in value) {
          form.files.add(MapEntry(prefix, f as MultipartFile));
        }
      } else {
        for (var i = 0; i < value.length; i++) {
          _addFields(form, '$prefix[$i]', value[i]);
        }
      }
    } else if (value is MultipartFile) {
      form.files.add(MapEntry(prefix, value));
    } else {
      form.fields.add(MapEntry(prefix, value.toString()));
    }
  }

  void dispose() => _dio.close();
}