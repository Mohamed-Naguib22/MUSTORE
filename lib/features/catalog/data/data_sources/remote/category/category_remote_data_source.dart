import 'package:mustore/features/catalog/data/models/category/category_model.dart';

abstract interface class CategoryRemoteDataSource {
  Future<List<CategoryModel>> rootCategories(int take);
}