import 'package:equatable/equatable.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/features/profile/domain/entities/contact.dart';

class ContactState extends Equatable {
  const ContactState({
    this.status = RequestStatus.initial,
    this.addStatus = RequestStatus.initial,
    this.updateStatus = RequestStatus.initial,
    this.setPrimaryStatus = RequestStatus.initial,
    this.deleteStatus = RequestStatus.initial,
    this.sendCodeStatus = RequestStatus.initial,
    this.verifyStatus = RequestStatus.initial,
    this.contacts = const [],
    this.failure,
  });

  final RequestStatus status;
  final RequestStatus addStatus;
  final RequestStatus updateStatus;
  final RequestStatus setPrimaryStatus;
  final RequestStatus deleteStatus;
  final RequestStatus sendCodeStatus;
  final RequestStatus verifyStatus;
  final List<Contact> contacts;
  final Failure? failure;

  Contact? get primaryContact {
    for (final contact in contacts) {
      if (contact.isPrimary) return contact;
    }
    return null;
  }

  Contact? contactById(String id) {
    for (final c in contacts) {
      if (c.id == id) return c;
    }
    return null;
  }

  ContactState copyWith({
    RequestStatus? status,
    RequestStatus? addStatus,
    RequestStatus? updateStatus,
    RequestStatus? setPrimaryStatus,
    RequestStatus? deleteStatus,
    RequestStatus? sendCodeStatus,
    RequestStatus? verifyStatus,
    List<Contact>? contacts,
    Failure? failure,
    bool clearFailure = false,
  }) =>
      ContactState(
        status: status ?? this.status,
        addStatus: addStatus ?? this.addStatus,
        updateStatus: updateStatus ?? this.updateStatus,
        setPrimaryStatus: setPrimaryStatus ?? this.setPrimaryStatus,
        deleteStatus: deleteStatus ?? this.deleteStatus,
        sendCodeStatus: sendCodeStatus ?? this.sendCodeStatus,
        verifyStatus: verifyStatus ?? this.verifyStatus,
        contacts: contacts ?? this.contacts,
        failure: clearFailure ? null : (failure ?? this.failure),
      );

  @override
  List<Object?> get props => [
    status,
    addStatus,
    updateStatus,
    setPrimaryStatus,
    deleteStatus,
    sendCodeStatus,
    verifyStatus,
    contacts,
    failure,
  ];
}