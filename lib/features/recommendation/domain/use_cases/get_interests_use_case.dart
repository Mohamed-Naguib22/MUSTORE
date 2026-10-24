import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/recommendation/domain/entities/interest_tag.dart';
import 'package:mustore/features/recommendation/domain/repositories/interests_repository.dart';

class GetInterestsUseCase implements UseCase<List<InterestTag>, String> {
  const GetInterestsUseCase(this._repository);
  final InterestsRepository _repository;

  @override
  Future<Either<Failure, List<InterestTag>>> call(String params) async =>
      await _repository.getInterests(params);
}