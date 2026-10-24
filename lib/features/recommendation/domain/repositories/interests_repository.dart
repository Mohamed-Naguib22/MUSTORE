import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/features/recommendation/domain/entities/interest_tag.dart';

abstract interface class InterestsRepository {
  Future<Either<Failure, List<InterestTag>>> getInterests(String searchTerm);
  Future<Either<Failure, Unit>> setInterests(List<String> interests);
}