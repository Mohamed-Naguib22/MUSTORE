import 'package:mustore/features/lookup/data/models/lookup_model.dart';

abstract interface class LocationRemoteDataSource {
  Future<List<LookupModel>> getCountries();
  Future<List<LookupModel>> getGovernoratesByCountryId(String countryId);
  Future<List<LookupModel>> getCitiesByGovernorateId(String governorateId);
}