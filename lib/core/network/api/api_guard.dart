import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mustore/core/error/exceptions.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/network/http/http_status_codes.dart';

Future<Either<Failure, T>> guardApiCall<T>(Future<T> Function() call) async {
  try {
    return right(await call());
  } on DioException catch (e) {
    return left(failureFromDio(e));
  } on NoDataFoundException {
    return left(const NoDataFailure());
  } catch (_) {
    return left(const UnknownFailure());
  }
}

Failure failureFromDio(DioException e) {
  if (e.error is Failure) return e.error as Failure;

  return switch (e.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.transformTimeout ||
    DioExceptionType.connectionError ||
    DioExceptionType.badCertificate =>
    const NetworkFailure(),
    DioExceptionType.badResponse => _failureFromResponse(e.response),
    DioExceptionType.cancel => const CancelledFailure(),
    DioExceptionType.unknown => const UnknownFailure(),
  };
}

Failure _failureFromResponse(Response<dynamic>? response) {
  final statusCode = response?.statusCode;
  final data = response?.data;

  final isClientError =
      statusCode != null && statusCode >= 400 && statusCode < 500;

  String? message;
  if (isClientError && data is Map<String, dynamic>) {
    final errors = data['Errors'];
    message = errors is List && errors.isNotEmpty
        ? errors.join('\n')
        : data['message'] as String?;
  }

  return ServerFailure(statusCode: statusCode, serverMessage: message);
}

extension DioExceptionX on DioException {
  bool get isUnauthorized =>
      response?.statusCode == HttpStatusCodes.unauthorized;
}

extension FailureX on Failure {
  DioException toDioException(RequestOptions options) => DioException(
    requestOptions: options,
    error: this,
    type: DioExceptionType.unknown,
  );
}