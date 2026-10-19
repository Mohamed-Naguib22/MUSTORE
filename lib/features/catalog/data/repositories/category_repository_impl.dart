import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/network/connectivity/network_connection.dart';
import 'package:mustore/core/utils/mixins/network_mixin.dart';
import 'package:mustore/features/catalog/data/data_sources/remote/category/category_remote_data_source.dart';
import 'package:mustore/features/catalog/domain/entities/category/category.dart';
import 'package:mustore/features/catalog/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl with NetworkMixin implements CategoryRepository {
  const CategoryRepositoryImpl({
    required this.networkConnection,
    required CategoryRemoteDataSource remoteDataSource,
  })  : _remote = remoteDataSource;

  @override
  final NetworkConnection networkConnection;

  final CategoryRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<Category>>> rootCategories() =>
      onlineOnly<List<Category>>(() => _remote.rootCategories());
}