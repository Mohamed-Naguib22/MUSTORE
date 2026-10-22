import 'package:mustore/features/profile/data/models/address_model.dart';
import 'package:mustore/features/profile/domain/params/address/add_address_params.dart';
import 'package:mustore/features/profile/domain/params/address/update_address_params.dart';

abstract interface class AddressRemoteDataSource {
  Future<List<AddressModel>> getAddresses();
  Future<AddressModel> addAddress(AddAddressParams params);
  Future<void> updateAddress(UpdateAddressParams params);
  Future<void> setAddressAsDefault(String addressId);
  Future<void> deleteAddress(String addressId);
}