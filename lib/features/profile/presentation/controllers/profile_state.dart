import 'package:equatable/equatable.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/features/profile/domain/entities/user_profile.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.status = RequestStatus.initial,
    this.updateStatus = RequestStatus.initial,
    this.pictureStatus = RequestStatus.initial,
    this.deleteAccountStatus = RequestStatus.initial,
    this.pictureVersion = 0,
    this.profile,
    this.failure,
  });

  final RequestStatus status;
  final RequestStatus updateStatus;
  final RequestStatus pictureStatus;
  final RequestStatus deleteAccountStatus;
  final int pictureVersion;
  final UserProfile? profile;
  final Failure? failure;

  ProfileState copyWith({
    RequestStatus? status,
    RequestStatus? updateStatus,
    RequestStatus? pictureStatus,
    RequestStatus? deleteAccountStatus,
    int? pictureVersion,
    UserProfile? profile,
    Failure? failure,
    bool clearProfile = false,
    bool clearFailure = false,
  }) =>
      ProfileState(
        status: status ?? this.status,
        updateStatus: updateStatus ?? this.updateStatus,
        pictureStatus: pictureStatus ?? this.pictureStatus,
        deleteAccountStatus: deleteAccountStatus ?? this.deleteAccountStatus,
        pictureVersion: pictureVersion ?? this.pictureVersion,
        profile: clearProfile ? null : (profile ?? this.profile),
        failure: clearFailure ? null : (failure ?? this.failure),
      );

  @override
  List<Object?> get props => [
    status,
    updateStatus,
    pictureStatus,
    deleteAccountStatus,
    pictureVersion,
    profile,
    failure,
  ];
}