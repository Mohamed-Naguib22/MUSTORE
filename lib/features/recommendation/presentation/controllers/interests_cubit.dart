import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/utils/mixins/safe_emit_mixin.dart';
import 'package:mustore/features/recommendation/domain/use_cases/get_interests_use_case.dart';
import 'package:mustore/features/recommendation/domain/use_cases/set_interests_use_case.dart';
import 'package:mustore/features/recommendation/presentation/controllers/interests_state.dart';

class InterestsCubit extends Cubit<InterestsState>
    with SafeEmitMixin<InterestsState> {

  InterestsCubit({
    required GetInterestsUseCase getInterestTags,
    required SetInterestsUseCase setInterestTags,
  }) :
        _getInterestTags = getInterestTags,
        _setInterestTags = setInterestTags,
        super(const InterestsState());

  final GetInterestsUseCase _getInterestTags;
  final SetInterestsUseCase _setInterestTags;

  Future<void> fetchInterestTags(String searchTerm) async {
    if (state.status.isLoading) return;

    safeEmit(state.copyWith(status: RequestStatus.loading, clearFailure: true));

    final result = await _getInterestTags(searchTerm);

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        status: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (interestTags) => state.copyWith(
        status: RequestStatus.success,
        interestTags: interestTags,
        clearFailure: true,
      ),
    );
  }

  Future<void> addAddress(List<String> interests) async {
    if (state.addStatus.isLoading) return;

    safeEmit(
      state.copyWith(addStatus: RequestStatus.loading, clearFailure: true),
    );

    final result = await _setInterestTags(interests);

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        addStatus: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (added) => state.copyWith(
        addStatus: RequestStatus.success,
        clearFailure: true,
      ),
    );
  }
}