import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/features/profile/domain/entities/user_profile.dart';
import 'package:mustore/features/profile/domain/params/update_profile_params.dart';

abstract interface class AccountRepository {
  Future<Either<Failure, UserProfile>> getProfile();
  Future<Either<Failure, Unit>> updateProfile(UpdateProfileParams params);
  Future<Either<Failure, Unit>> deleteAccount();
  Future<Either<Failure, Unit>> setProfilePicture(String filePath);
  Future<Either<Failure, Unit>> deleteProfilePicture();
}