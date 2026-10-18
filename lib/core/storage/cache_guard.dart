import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';

Future<Either<Failure, T>> guardCache<T>(Future<T> Function() call) async {
  try {
    return Right(await call());
  } catch (_) {
    return const Left(CacheFailure());
  }
}