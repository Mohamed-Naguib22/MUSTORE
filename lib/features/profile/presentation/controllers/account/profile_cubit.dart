import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/utils/mixins/safe_emit_mixin.dart';
import 'package:mustore/features/profile/domain/params/account/update_profile_params.dart';
import 'package:mustore/features/profile/domain/use_cases/account/delete_account_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/account/delete_profile_picture_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/account/get_profile_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/account/set_profile_picture_use_case.dart';
import 'package:mustore/features/profile/domain/use_cases/account/update_profile_use_case.dart';
import 'package:mustore/features/profile/presentation/controllers/account/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState>
    with SafeEmitMixin<ProfileState> {
  ProfileCubit({
    required GetProfileUseCase getProfile,
    required UpdateProfileUseCase updateProfile,
    required DeleteAccountUseCase deleteAccount,
    required SetProfilePictureUseCase setProfilePicture,
    required DeleteProfilePictureUseCase deleteProfilePicture,
  })  : _getProfile = getProfile,
        _updateProfile = updateProfile,
        _deleteAccount = deleteAccount,
        _setProfilePicture = setProfilePicture,
        _deleteProfilePicture = deleteProfilePicture,
        super(const ProfileState());

  final GetProfileUseCase _getProfile;
  final UpdateProfileUseCase _updateProfile;
  final DeleteAccountUseCase _deleteAccount;
  final SetProfilePictureUseCase _setProfilePicture;
  final DeleteProfilePictureUseCase _deleteProfilePicture;

  Future<void> fetchProfile({bool silent = false}) async {
    if (state.status.isLoading) return;

    if (!silent) {
      safeEmit(
        state.copyWith(status: RequestStatus.loading, clearFailure: true),
      );
    }

    final result = await _getProfile(const NoParams());

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        status: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (profile) => state.copyWith(
        status: RequestStatus.success,
        profile: profile,
        clearFailure: true,
      ),
    );
  }

  Future<void> updateProfile(UpdateProfileParams params) async {
    if (state.updateStatus.isLoading) return;

    safeEmit(
      state.copyWith(
        updateStatus: RequestStatus.loading,
        clearFailure: true,
      ),
    );

    final result = await _updateProfile(params);

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
      await fetchProfile(silent: true);
    }
  }

  Future<void> setProfilePicture(String filePath) async {
    if (state.pictureStatus.isLoading) return;

    safeEmit(
      state.copyWith(
        pictureStatus: RequestStatus.loading,
        clearFailure: true,
      ),
    );

    final result = await _setProfilePicture(filePath);

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        pictureStatus: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (_) => state.copyWith(
        pictureStatus: RequestStatus.success,
        pictureVersion: state.pictureVersion + 1,
        clearFailure: true,
      ),
    );

    if (state.pictureStatus == RequestStatus.success) {
      await fetchProfile(silent: true);
    }
  }

  Future<void> deleteProfilePicture() async {
    if (state.pictureStatus.isLoading) return;

    safeEmit(
      state.copyWith(
        pictureStatus: RequestStatus.loading,
        clearFailure: true,
      ),
    );

    final result = await _deleteProfilePicture(const NoParams());

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        pictureStatus: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (_) => state.copyWith(
        pictureStatus: RequestStatus.success,
        pictureVersion: state.pictureVersion + 1,
        clearFailure: true,
      ),
    );

    if (state.pictureStatus == RequestStatus.success) {
      await fetchProfile(silent: true);
    }
  }

  Future<void> deleteAccount() async {
    if (state.deleteAccountStatus.isLoading) return;

    safeEmit(
      state.copyWith(
        deleteAccountStatus: RequestStatus.loading,
        clearFailure: true,
      ),
    );

    final result = await _deleteAccount(const NoParams());

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        deleteAccountStatus: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (_) => state.copyWith(
        deleteAccountStatus: RequestStatus.success,
        clearFailure: true,
      ),
    );
  }

  void reset() => safeEmit(const ProfileState());
}