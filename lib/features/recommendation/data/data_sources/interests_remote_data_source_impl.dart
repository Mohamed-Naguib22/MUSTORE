import 'package:dartz/dartz.dart';
import 'package:mustore/core/network/api/api_client.dart';
import 'package:mustore/features/lookup/data/models/lookup_model.dart';
import 'package:mustore/features/recommendation/data/constants/recommendation_endpoints.dart';
import 'package:mustore/features/recommendation/data/data_sources/interests_remote_data_source.dart';

class InterestsRemoteDataSourceImpl implements InterestsRemoteDataSource {
  const InterestsRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<List<LookupModel>> getInterests(String searchTerm) async {
    final response = await _apiClient.get(
        path: RecommendationEndpoints.getInterests,
        query: {
          'searchTerm': searchTerm,
        }
    );

    return LookupModel.listFromJson(response.data as List);
  }

  @override
  Future<Unit> setInterests(List<String> interests) async {
    await _apiClient.post(
        path: RecommendationEndpoints.setInterests,
        data: {
          'names': interests,
        }
    );

    return unit;
  }
}