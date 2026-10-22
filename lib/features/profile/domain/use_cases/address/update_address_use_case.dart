import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/profile/domain/params/address/update_address_params.dart';
import 'package:mustore/features/profile/domain/repositories/address_repository.dart';

class UpdateAddressUseCase implements UseCase<Unit, UpdateAddressParams> {
  const UpdateAddressUseCase(this._repository);
  final AddressRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(UpdateAddressParams params) async =>
      await _repository.updateAddress(params);
}