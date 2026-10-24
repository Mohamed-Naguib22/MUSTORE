import 'package:dartz/dartz.dart';
import 'package:mustore/features/lookup/data/models/lookup_model.dart';

abstract interface class InterestsRemoteDataSource {
  Future<List<LookupModel>> getInterests(String searchTerm);
  Future<Unit> setInterests(List<String> interests);
}