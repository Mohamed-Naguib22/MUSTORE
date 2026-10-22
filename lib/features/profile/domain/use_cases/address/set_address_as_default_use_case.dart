import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/features/profile/domain/repositories/address_repository.dart';

class SetAddressAsDefaultUseCase implements UseCase<Unit, String> {
  const SetAddressAsDefaultUseCase(this._repository);
  final AddressRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(String addressId) async =>
      await _repository.setAddressAsDefault(addressId);
}