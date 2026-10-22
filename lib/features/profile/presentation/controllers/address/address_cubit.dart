import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/utils/mixins/safe_emit_mixin.dart';
import 'package:mustore/features/profile/domain/params/address/add_address_params.dart';
import 'package:mustore/features/profile/domain/params/address/update_address_params.dart';
import 'package:mustore/features/profile/domain/use_cases/address/add_address_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/address/delete_address_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/address/get_addresses_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/address/set_address_as_default_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/address/update_address_use_case.dart';
import 'package:mustore/features/profile/presentation/controllers/address/address_state.dart';

class AddressCubit extends Cubit<AddressState>
    with SafeEmitMixin<AddressState> {
  AddressCubit({
    required GetAddressesUseCase getAddresses,
    required AddAddressUseCase addAddress,
    required UpdateAddressUseCase updateAddress,
    required SetAddressAsDefaultUseCase setAddressAsDefault,
    required DeleteAddressUseCase deleteAddress,
  })  : _getAddresses = getAddresses,
        _addAddress = addAddress,
        _updateAddress = updateAddress,
        _setAddressAsDefault = setAddressAsDefault,
        _deleteAddress = deleteAddress,
        super(const AddressState());

  final GetAddressesUseCase _getAddresses;
  final AddAddressUseCase _addAddress;
  final UpdateAddressUseCase _updateAddress;
  final SetAddressAsDefaultUseCase _setAddressAsDefault;
  final DeleteAddressUseCase _deleteAddress;

  Future<void> fetchAddresses({bool silent = false}) async {
    if (state.status.isLoading) return;

    if (!silent) {
      safeEmit(
        state.copyWith(status: RequestStatus.loading, clearFailure: true),
      );
    }

    final result = await _getAddresses(const NoParams());

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        status: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (addresses) => state.copyWith(
        status: RequestStatus.success,
        addresses: addresses,
        clearFailure: true,
      ),
    );
  }

  Future<void> addAddress(AddAddressParams params) async {
    if (state.addStatus.isLoading) return;

    safeEmit(
      state.copyWith(addStatus: RequestStatus.loading, clearFailure: true),
    );

    final result = await _addAddress(params);

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        addStatus: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (_) => state.copyWith(
        addStatus: RequestStatus.success,
        clearFailure: true,
      ),
    );

    if (state.addStatus == RequestStatus.success) {
      await fetchAddresses(silent: true);
    }
  }

  Future<void> updateAddress(UpdateAddressParams params) async {
    if (state.updateStatus.isLoading) return;

    safeEmit(
      state.copyWith(updateStatus: RequestStatus.loading, clearFailure: true),
    );

    final result = await _updateAddress(params);

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        updateStatus: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (_) => state.copyWith(
        updateStatus: RequestStatus.success,
        clearFailure: true,
      ),
    );

    if (state.updateStatus == RequestStatus.success) {
      await fetchAddresses(silent: true);
    }
  }

  Future<void> setAddressAsDefault(String addressId) async {
    if (state.setDefaultStatus.isLoading) return;

    safeEmit(
      state.copyWith(
        setDefaultStatus: RequestStatus.loading,
        clearFailure: true,
      ),
    );

    final result = await _setAddressAsDefault(addressId);

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        setDefaultStatus: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (_) => state.copyWith(
        setDefaultStatus: RequestStatus.success,
        clearFailure: true,
      ),
    );

    if (state.setDefaultStatus == RequestStatus.success) {
      await fetchAddresses(silent: true);
    }
  }

  Future<void> deleteAddress(String addressId) async {
    if (state.deleteStatus.isLoading) return;

    safeEmit(
      state.copyWith(deleteStatus: RequestStatus.loading, clearFailure: true),
    );

    final result = await _deleteAddress(addressId);

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        deleteStatus: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (_) => state.copyWith(
        deleteStatus: RequestStatus.success,
        clearFailure: true,
      ),
    );

    if (state.deleteStatus == RequestStatus.success) {
      await fetchAddresses(silent: true);
    }
  }

  void reset() => safeEmit(const AddressState());
}