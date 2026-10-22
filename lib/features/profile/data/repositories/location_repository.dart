import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/network/connectivity/network_connection.dart';
import 'package:mustore/core/utils/mixins/network_mixin.dart';
import 'package:mustore/features/profile/data/data_sources/address/location_remote_data_source.dart';
import 'package:mustore/features/profile/domain/entities/city.dart';
import 'package:mustore/features/profile/domain/entities/country.dart';
import 'package:mustore/features/profile/domain/entities/governorate.dart';
import 'package:mustore/features/profile/domain/repositories/location_repository.dart';

class LocationRepositoryImpl with NetworkMixin implements LocationRepository {
  const LocationRepositoryImpl({
    required this.networkConnection,
    required LocationRemoteDataSource remoteDataSource,
  }) : _remote = remoteDataSource;

  @override
  final NetworkConnection networkConnection;

  final LocationRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<Country>>> getCountries() =>
      onlineOnly<List<Country>>(() => _remote.getCountries());

  @override
  Future<Either<Failure, List<Governorate>>> getGovernoratesByCountryId(
      String countryId,
      ) =>
      onlineOnly<List<Governorate>>(
            () => _remote.getGovernoratesByCountryId(countryId),
      );

  @override
  Future<Either<Failure, List<City>>> getCitiesByGovernorateId(
      String governorateId,
      ) =>
      onlineOnly<List<City>>(
            () => _remote.getCitiesByGovernorateId(governorateId),
      );
}