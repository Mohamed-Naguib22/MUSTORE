import 'package:flutter/widgets.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/generated/l10n.dart';

extension FailureMessage on Failure {
  String localizedMessage(BuildContext context) {
    final l10n = S.of(context);

    return switch (this) {
      NetworkFailure() => l10n.failureNetwork,
      ServerFailure(serverMessage: final message?) => message,
      ServerFailure(statusCode: 401) => l10n.failureSessionExpired,
      ServerFailure(statusCode: 404) => l10n.failureNotFound,
      ServerFailure(statusCode: final code?) when code >= 500 =>
      l10n.failureServer,
      ServerFailure() => l10n.failureGeneric,
      NoDataFailure() => l10n.failureNoData,
      CancelledFailure() => '',
      UnknownFailure() => l10n.failureGeneric,
      CacheFailure() => l10n.failureCache,
    };
  }
}