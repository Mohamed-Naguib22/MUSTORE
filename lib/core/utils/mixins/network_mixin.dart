import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/network/api/api_guard.dart';
import 'package:mustore/core/network/connectivity/network_connection.dart';

mixin NetworkMixin {
  NetworkConnection get networkConnection;

  Future<Either<Failure, T>> onlineOnly<T>(Future<T> Function() call) async {
    if (!await networkConnection.isConnected) {
      return left(const NetworkFailure());
    }
    return guardApiCall<T>(call);
  }
}