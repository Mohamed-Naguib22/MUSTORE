import 'package:dio/dio.dart';
import 'package:mustore/core/config/api_config.dart';

abstract interface class ApiClient {
  void setAuthToken(String token);
  void clearAuthToken();

  Future<Response> get({
    required String path,
    String? baseUrl = ApiConfig.baseUrl,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  });

  Future<Response> post({
    required String path,
    String? baseUrl = ApiConfig.baseUrl,
    Object? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    bool multipart = false,
  });

  Future<Response> put({
    required String path,
    String? baseUrl = ApiConfig.baseUrl,
    Object? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    bool multipart = false,
  });

  Future<Response> patch({
    required String path,
    String? baseUrl = ApiConfig.baseUrl,
    Object? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    bool multipart = false,
  });

  Future<Response> delete({
    required String path,
    String? baseUrl = ApiConfig.baseUrl,
    Object? data,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  });
}