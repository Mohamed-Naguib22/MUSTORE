import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/features/profile/domain/entities/city.dart';
import 'package:mustore/features/profile/domain/entities/country.dart';
import 'package:mustore/features/profile/domain/entities/governorate.dart';

abstract interface class LocationRepository {
  Future<Either<Failure, List<Country>>> getCountries();
  Future<Either<Failure, List<Governorate>>> getGovernoratesByCountryId(String countryId,);
  Future<Either<Failure, List<City>>> getCitiesByGovernorateId(String governorateId,);
}