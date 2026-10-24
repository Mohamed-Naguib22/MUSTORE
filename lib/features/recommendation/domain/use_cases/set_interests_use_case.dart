import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/recommendation/domain/repositories/interests_repository.dart';

class SetInterestsUseCase implements UseCase<Unit, List<String>> {
  const SetInterestsUseCase(this._repository);
  final InterestsRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(List<String> params) async =>
      await _repository.setInterests(params);
}