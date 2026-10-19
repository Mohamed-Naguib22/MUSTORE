import 'package:mustore/core/network/api/api_client.dart';
import 'package:mustore/core/network/api/json_list_extension.dart';
import 'package:mustore/features/catalog/data/constants/category_endpoints.dart';
import 'package:mustore/features/catalog/data/models/category/category_model.dart';
import 'category_remote_data_source.dart';

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  const CategoryRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<List<CategoryModel>> rootCategories() async {
    final response = await _apiClient.get(
      path: CategoryEndpoints.rootCategories,
    );

    return (response.data as List<dynamic>).toModels(CategoryModel.fromJson);
  }
}