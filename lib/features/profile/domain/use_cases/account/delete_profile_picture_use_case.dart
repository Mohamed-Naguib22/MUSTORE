import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/profile/domain/repositories/account_repository.dart';

class DeleteProfilePictureUseCase implements UseCase<Unit, NoParams> {
  const DeleteProfilePictureUseCase(this._repository);
  final AccountRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async =>
      await _repository.deleteProfilePicture();
}