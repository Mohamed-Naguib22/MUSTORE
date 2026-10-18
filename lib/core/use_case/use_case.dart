import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';

abstract interface class UseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}

final class NoParams {
  const NoParams();
}