import 'package:dartz/dartz.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/network/connectivity/network_connection.dart';
import 'package:mustore/core/utils/mixins/network_mixin.dart';
import 'package:mustore/features/profile/data/data_sources/address/address_remote_data_source.dart';
import 'package:mustore/features/profile/domain/entities/address.dart';
import 'package:mustore/features/profile/domain/params/address/add_address_params.dart';
import 'package:mustore/features/profile/domain/params/address/update_address_params.dart';
import 'package:mustore/features/profile/domain/repositories/address_repository.dart';

class AddressRepositoryImpl with NetworkMixin implements AddressRepository {
  const AddressRepositoryImpl({
    required this.networkConnection,
    required AddressRemoteDataSource remoteDataSource,
  }) : _remote = remoteDataSource;

  @override
  final NetworkConnection networkConnection;

  final AddressRemoteDataSource _remote;

  @override
  Future<Either<Failure, List<Address>>> getAddresses() =>
      onlineOnly<List<Address>>(() async => await _remote.getAddresses());

  @override
  Future<Either<Failure, Address>> addAddress(AddAddressParams params) =>
      onlineOnly<Address>(() async => await _remote.addAddress(params));

  @override
  Future<Either<Failure, Unit>> updateAddress(UpdateAddressParams params) =>
      onlineOnly<Unit>(() async {
        await _remote.updateAddress(params);
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> setAddressAsDefault(String addressId) =>
      onlineOnly<Unit>(() async {
        await _remote.setAddressAsDefault(addressId);
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> deleteAddress(String addressId) =>
      onlineOnly<Unit>(() async {
        await _remote.deleteAddress(addressId);
        return unit;
      });
}