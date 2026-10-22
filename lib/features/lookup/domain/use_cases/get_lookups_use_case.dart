import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/lookup/domain/entities/lookup.dart';

class GetLookupsUseCase<P> implements UseCase<List<Lookup>, P> {
  const GetLookupsUseCase(this._fetch);

  final Future<Either<Failure, List<Lookup>>> Function(P params) _fetch;

  @override
  Future<Either<Failure, List<Lookup>>> call(P params) => _fetch(params);
}