import 'package:flutter/widgets.dart';
import 'package:mustore/core/error/failure.dart';

extension FailureMessage on Failure {
  String localizedMessage(BuildContext context) {
    return switch (this) {
      NetworkFailure() => 'No internet connection',
      ServerFailure(serverMessage: final message?) => message,
      ServerFailure(statusCode: 401) =>
      'Your session has expired, please log in again',
      ServerFailure(statusCode: 404) => 'The requested item was not found',
      ServerFailure(statusCode: final code?) when code >= 500 =>
      'Server error, please try again later',
      ServerFailure() => 'Something went wrong, please try again',
      NoDataFailure() => 'No saved data available',
      CancelledFailure() => '',
      UnknownFailure() => 'Something went wrong, please try again',
    };
  }
}