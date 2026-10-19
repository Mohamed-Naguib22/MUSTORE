import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';

abstract interface class LocationService {
  Future<Either<Failure, String>> currentLocationName();
}