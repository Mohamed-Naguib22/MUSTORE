import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/profile/domain/repositories/account_repository.dart';

class SetProfilePictureUseCase implements UseCase<String, String> {
  const SetProfilePictureUseCase(this._repository);
  final AccountRepository _repository;

  @override
  Future<Either<Failure, String>> call(String filePath) async =>
      await _repository.setProfilePicture(filePath);
}