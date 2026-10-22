import 'package:mustore/core/network/api/api_client.dart';
import 'package:mustore/features/profile/data/constants/address_endpoints.dart';
import 'package:mustore/features/profile/data/models/address_model.dart';
import 'package:mustore/features/profile/domain/params/address/add_address_params.dart';
import 'package:mustore/features/profile/domain/params/address/update_address_params.dart';

import 'address_remote_data_source.dart';

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  const AddressRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<List<AddressModel>> getAddresses() async {
    final response = await _apiClient.get(path: AddressEndpoints.getAll);

    return (response.data as List)
        .map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<AddressModel> addAddress(AddAddressParams params) async {
    final response = await _apiClient.post(
      path: AddressEndpoints.add,
      data: params.toJson(),
    );

    return AddressModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> updateAddress(UpdateAddressParams params) async {
    if (params.isEmpty) return;

    await _apiClient.put(
      path: AddressEndpoints.update(params.id),
      data: params.toJson(),
    );
  }

  @override
  Future<void> setAddressAsDefault(String addressId) async {
    await _apiClient.patch(path: AddressEndpoints.setAsDefault(addressId));
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    await _apiClient.delete(path: AddressEndpoints.delete(addressId));
  }
}