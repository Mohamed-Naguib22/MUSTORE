import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/network/connectivity/network_connection.dart';
import 'package:mustore/core/utils/mixins/network_mixin.dart';
import 'package:mustore/features/recommendation/data/data_sources/interests_remote_data_source.dart';
import 'package:mustore/features/recommendation/domain/entities/interest_tag.dart';
import 'package:mustore/features/recommendation/domain/repositories/interests_repository.dart';

class InterestsRepositoryImpl with NetworkMixin implements InterestsRepository {
  const InterestsRepositoryImpl({
    required this.networkConnection,
    required InterestsRemoteDataSource remoteDataSource,
  })  : _remote = remoteDataSource;

  @override
  final NetworkConnection networkConnection;

  final InterestsRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<InterestTag>>> getInterests(String searchTerm) =>
      onlineOnly<List<InterestTag>>(() => _remote.getInterests(searchTerm));

  @override
  Future<Either<Failure, Unit>> setInterests(List<String> interests) =>
      onlineOnly<Unit>(() => _remote.setInterests(interests));
}