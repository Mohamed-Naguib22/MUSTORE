import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/profile/domain/entities/user_profile.dart';
import 'package:mustore/features/profile/domain/repositories/account_repository.dart';

class GetProfileUseCase implements UseCase<UserProfile, NoParams> {
  const GetProfileUseCase(this._repository);
  final AccountRepository _repository;

  @override
  Future<Either<Failure, UserProfile>> call(NoParams params) async =>
      await _repository.getProfile();
}