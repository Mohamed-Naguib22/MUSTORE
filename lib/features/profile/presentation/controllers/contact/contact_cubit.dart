import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/services/encryption/otp_encryption_service.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/utils/mixins/safe_emit_mixin.dart';
import 'package:mustore/features/profile/domain/entities/contact.dart';
import 'package:mustore/features/profile/domain/params/contact/update_contact_params.dart';
import 'package:mustore/features/profile/domain/params/contact/verify_contact_params.dart';
import 'package:mustore/features/profile/domain/use_cases/contact/add_contact_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/contact/delete_contact_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/contact/get_contacts_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/contact/send_contact_verification_code_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/contact/set_primary_contact_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/contact/update_contact_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/contact/verify_contact_use_case.dart';
import 'package:mustore/features/profile/presentation/controllers/contact/contact_state.dart';

class ContactCubit extends Cubit<ContactState>
    with SafeEmitMixin<ContactState> {
  ContactCubit({
    required GetContactsUseCase getContacts,
    required AddContactUseCase addContact,
    required UpdateContactUseCase updateContact,
    required SetPrimaryContactUseCase setPrimaryContact,
    required DeleteContactUseCase deleteContact,
    required SendContactVerificationCodeUseCase sendVerificationCode,
    required VerifyContactUseCase verifyContact,
    required OtpEncryptionService otpEncryptionService,
  })  : _getContacts = getContacts,
        _addContact = addContact,
        _updateContact = updateContact,
        _setPrimaryContact = setPrimaryContact,
        _deleteContact = deleteContact,
        _sendVerificationCode = sendVerificationCode,
        _verifyContact = verifyContact,
        _otpEncryptionService = otpEncryptionService,
        super(const ContactState());

  final GetContactsUseCase _getContacts;
  final AddContactUseCase _addContact;
  final UpdateContactUseCase _updateContact;
  final SetPrimaryContactUseCase _setPrimaryContact;
  final DeleteContactUseCase _deleteContact;
  final SendContactVerificationCodeUseCase _sendVerificationCode;
  final VerifyContactUseCase _verifyContact;
  final OtpEncryptionService _otpEncryptionService;

  Future<void> fetchContacts() async {
    if (state.status.isLoading) return;

    safeEmit(
      state.copyWith(status: RequestStatus.loading, clearFailure: true),
    );

    final result = await _getContacts(const NoParams());

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        status: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (contacts) => state.copyWith(
        status: RequestStatus.success,
        contacts: contacts,
        clearFailure: true,
      ),
    );
  }

  Future<void> addContact(String phoneNumber) async {
    if (state.addStatus.isLoading) return;

    safeEmit(
      state.copyWith(addStatus: RequestStatus.loading, clearFailure: true),
    );

    final result = await _addContact(phoneNumber);

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        addStatus: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (added) => state.copyWith(
        addStatus: RequestStatus.success,
        contacts: [
          for (final c in state.contacts)
            added.isPrimary ? c.copyWith(isPrimary: false) : c,
          added,
        ],
        clearFailure: true,
      ),
    );
  }

  Future<void> updateContact(
      UpdateContactParams params,
      Contact updated,
      ) async {
    if (state.updateStatus.isLoading) return;

    safeEmit(
      state.copyWith(updateStatus: RequestStatus.loading, clearFailure: true),
    );

    final phoneChanged =
        state.contactById(updated.id)?.phoneNumber != updated.phoneNumber;
    final next = phoneChanged ? updated.copyWith(isVerified: false) : updated;

    final result = await _updateContact(params);

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        updateStatus: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (_) => state.copyWith(
        updateStatus: RequestStatus.success,
        contacts: [
          for (final c in state.contacts) c.id == next.id ? next : c,
        ],
        clearFailure: true,
      ),
    );
  }

  Future<void> setContactAsPrimary(String contactId) async {
    if (state.setPrimaryStatus.isLoading) return;

    safeEmit(
      state.copyWith(
        setPrimaryStatus: RequestStatus.loading,
        clearFailure: true,
      ),
    );

    final result = await _setPrimaryContact(contactId);

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        setPrimaryStatus: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (_) => state.copyWith(
        setPrimaryStatus: RequestStatus.success,
        contacts: [
          for (final c in state.contacts)
            c.copyWith(isPrimary: c.id == contactId),
        ],
        clearFailure: true,
      ),
    );
  }

  Future<void> deleteContact(String contactId) async {
    if (state.deleteStatus.isLoading) return;

    final contact = state.contactById(contactId);
    if (contact == null || contact.isPrimary) return;

    safeEmit(
      state.copyWith(deleteStatus: RequestStatus.loading, clearFailure: true),
    );

    final result = await _deleteContact(contactId);

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        deleteStatus: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (_) => state.copyWith(
        deleteStatus: RequestStatus.success,
        contacts: state.contacts.where((c) => c.id != contactId).toList(),
        clearFailure: true,
      ),
    );
  }

  Future<void> sendVerificationCode(String contactId) async {
    if (state.sendCodeStatus.isLoading) return;

    safeEmit(
      state.copyWith(sendCodeStatus: RequestStatus.loading, clearFailure: true),
    );

    final result = await _sendVerificationCode(contactId);

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        sendCodeStatus: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (_) => state.copyWith(
        sendCodeStatus: RequestStatus.success,
        clearFailure: true,
      ),
    );
  }

  Future<void> verifyContact({
    required String contactId,
    required String otp,
  }) async {
    if (state.verifyStatus.isLoading) return;

    safeEmit(
      state.copyWith(verifyStatus: RequestStatus.loading, clearFailure: true),
    );

    final params = VerifyContactParams(contactId: contactId, encryptedOtp: _otpEncryptionService.encrypt(otp));
    final result = await _verifyContact(params);

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        verifyStatus: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (_) => state.copyWith(
        verifyStatus: RequestStatus.success,
        contacts: [
          for (final c in state.contacts)
            c.id == contactId ? c.copyWith(isVerified: true) : c,
        ],
        clearFailure: true,
      ),
    );
  }

  void reset() => safeEmit(const ContactState());
}