import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/features/profile/domain/entities/address.dart';
import 'package:mustore/features/profile/domain/params/address/add_address_params.dart';
import 'package:mustore/features/profile/domain/params/address/update_address_params.dart';

abstract interface class AddressRepository {
  Future<Either<Failure, List<Address>>> getAddresses();
  Future<Either<Failure, Address>> addAddress(AddAddressParams params);
  Future<Either<Failure, Unit>> updateAddress(UpdateAddressParams params);
  Future<Either<Failure, Unit>> setAddressAsDefault(String addressId);
  Future<Either<Failure, Unit>> deleteAddress(String addressId);
}