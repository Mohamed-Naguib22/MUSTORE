import 'package:mustore/core/network/api/api_client.dart';
import 'package:mustore/features/lookup/data/models/lookup_model.dart';
import 'package:mustore/features/profile/data/constants/location_endpoints.dart';
import 'location_remote_data_source.dart';

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  const LocationRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<List<LookupModel>> getCountries() async {
    final response =
    await _apiClient.get(path: LocationEndpoints.getAllCountries);
    return LookupModel.listFromJson(response.data as List);
  }

  @override
  Future<List<LookupModel>> getGovernoratesByCountryId(
      String countryId,
      ) async {
    final response = await _apiClient.get(
      path: LocationEndpoints.getGovernoratesByCountryId(countryId),
    );
    return LookupModel.listFromJson(response.data as List);
  }

  @override
  Future<List<LookupModel>> getCitiesByGovernorateId(
      String governorateId,
      ) async {
    final response = await _apiClient.get(
      path: LocationEndpoints.getCitiesByGovernorateId(governorateId),
    );
    return LookupModel.listFromJson(response.data as List);
  }
}