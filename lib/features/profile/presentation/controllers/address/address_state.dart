import 'package:equatable/equatable.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/features/profile/domain/entities/address.dart';

class AddressState extends Equatable {
  const AddressState({
    this.status = RequestStatus.initial,
    this.addStatus = RequestStatus.initial,
    this.updateStatus = RequestStatus.initial,
    this.setDefaultStatus = RequestStatus.initial,
    this.deleteStatus = RequestStatus.initial,
    this.addresses = const [],
    this.failure,
  });

  final RequestStatus status;
  final RequestStatus addStatus;
  final RequestStatus updateStatus;
  final RequestStatus setDefaultStatus;
  final RequestStatus deleteStatus;
  final List<Address> addresses;
  final Failure? failure;

  Address? get defaultAddress {
    for (final address in addresses) {
      if (address.isDefault) return address;
    }
    return null;
  }

  AddressState copyWith({
    RequestStatus? status,
    RequestStatus? addStatus,
    RequestStatus? updateStatus,
    RequestStatus? setDefaultStatus,
    RequestStatus? deleteStatus,
    List<Address>? addresses,
    Failure? failure,
    bool clearFailure = false,
  }) =>
      AddressState(
        status: status ?? this.status,
        addStatus: addStatus ?? this.addStatus,
        updateStatus: updateStatus ?? this.updateStatus,
        setDefaultStatus: setDefaultStatus ?? this.setDefaultStatus,
        deleteStatus: deleteStatus ?? this.deleteStatus,
        addresses: addresses ?? this.addresses,
        failure: clearFailure ? null : (failure ?? this.failure),
      );

  @override
  List<Object?> get props => [
    status,
    addStatus,
    updateStatus,
    setDefaultStatus,
    deleteStatus,
    addresses,
    failure,
  ];
}