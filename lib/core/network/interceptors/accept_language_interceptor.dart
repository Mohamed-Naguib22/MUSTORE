import 'package:dio/dio.dart';
import 'package:mustore/core/network/http/http_header_keys.dart';
import 'package:mustore/core/services/localization/language_provider.dart';

class AcceptLanguageInterceptor extends Interceptor {
  AcceptLanguageInterceptor(this._languageProvider);

  final LanguageProvider _languageProvider;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[HeaderKeys.acceptLanguage] = _languageProvider.languageCode;
    handler.next(options);
  }
}