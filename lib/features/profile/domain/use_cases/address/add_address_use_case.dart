import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/profile/domain/entities/address.dart';
import 'package:mustore/features/profile/domain/params/address/add_address_params.dart';
import 'package:mustore/features/profile/domain/repositories/address_repository.dart';

class AddAddressUseCase implements UseCase<Address, AddAddressParams> {
  const AddAddressUseCase(this._repository);
  final AddressRepository _repository;

  @override
  Future<Either<Failure, Address>> call(AddAddressParams params) =>
      _repository.addAddress(params);
}