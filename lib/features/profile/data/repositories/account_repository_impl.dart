import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/network/connectivity/network_connection.dart';
import 'package:mustore/core/utils/mixins/network_mixin.dart';
import 'package:mustore/features/profile/data/data_sources/account/account_remote_data_source.dart';
import 'package:mustore/features/profile/domain/entities/user_profile.dart';
import 'package:mustore/features/profile/domain/params/update_profile_params.dart';
import 'package:mustore/features/profile/domain/repositories/account_repository.dart';

class AccountRepositoryImpl with NetworkMixin implements AccountRepository {
  const AccountRepositoryImpl({
    required this.networkConnection,
    required AccountRemoteDataSource remoteDataSource,
  }) : _remote = remoteDataSource;

  @override
  final NetworkConnection networkConnection;

  final AccountRemoteDataSource _remote;

  @override
  Future<Either<Failure, UserProfile>> getProfile() =>
      onlineOnly<UserProfile>(() => _remote.getProfile());

  @override
  Future<Either<Failure, Unit>> updateProfile(UpdateProfileParams params) =>
      onlineOnly<Unit>(() async {
        await _remote.updateProfile(params);
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> deleteAccount() =>
      onlineOnly<Unit>(() async {
        await _remote.deleteAccount();
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> setProfilePicture(String filePath) =>
      onlineOnly<Unit>(() async {
        await _remote.setProfilePicture(filePath);
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> deleteProfilePicture() =>
      onlineOnly<Unit>(() async {
        await _remote.deleteProfilePicture();
        return unit;
      });
}