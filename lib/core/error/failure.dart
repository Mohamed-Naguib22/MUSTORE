import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

final class NetworkFailure extends Failure {
  const NetworkFailure();
}

final class ServerFailure extends Failure {
  const ServerFailure({this.statusCode, this.serverMessage});

  final int? statusCode;

  final String? serverMessage;

  @override
  List<Object?> get props => [statusCode, serverMessage];
}

final class CancelledFailure extends Failure {
  const CancelledFailure();
}

final class UnknownFailure extends Failure {
  const UnknownFailure();
}

final class NoDataFailure extends Failure {
  const NoDataFailure();
}