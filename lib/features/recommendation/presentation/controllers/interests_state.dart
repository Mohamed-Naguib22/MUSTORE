import 'package:equatable/equatable.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/features/recommendation/domain/entities/interest_tag.dart';

class InterestsState extends Equatable {
  const InterestsState({
    this.status = RequestStatus.initial,
    this.addStatus = RequestStatus.initial,
    this.interestTags = const [],
    this.failure,
  });

  final RequestStatus status;
  final RequestStatus addStatus;
  final List<InterestTag> interestTags;
  final Failure? failure;

  InterestsState copyWith({
    RequestStatus? status,
    RequestStatus? addStatus,
    List<InterestTag>? interestTags,
    Failure? failure,
    bool clearFailure = false,
  }) =>
      InterestsState(
        status: status ?? this.status,
        addStatus: addStatus ?? this.addStatus,
        interestTags: interestTags ?? this.interestTags,
        failure: clearFailure ? null : (failure ?? this.failure),
      );

  @override
  List<Object?> get props => [status, addStatus, interestTags, failure];
}