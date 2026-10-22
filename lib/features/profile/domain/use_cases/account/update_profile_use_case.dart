import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/profile/domain/params/account/update_profile_params.dart';
import 'package:mustore/features/profile/domain/repositories/account_repository.dart';

class UpdateProfileUseCase implements UseCase<Unit, UpdateProfileParams> {
  const UpdateProfileUseCase(this._repository);
  final AccountRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(UpdateProfileParams params) =>
      _repository.updateProfile(params);
}