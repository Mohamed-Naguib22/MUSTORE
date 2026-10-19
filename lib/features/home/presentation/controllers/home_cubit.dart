import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/services/location/location_service.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/utils/mixins/safe_emit_mixin.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with SafeEmitMixin<HomeState> {
  HomeCubit({required LocationService locationService})
      : _locationService = locationService,
        super(const HomeState());

  final LocationService _locationService;

  Future<void> loadLocation() async {
    safeEmit(
      state.copyWith(
        locationStatus: RequestStatus.loading,
        clearFailure: true,
      ),
    );

    final result = await _locationService.currentLocationName();

    safeFold(
      result,
      onLeft: (failure) => state.copyWith(
        locationStatus: RequestStatus.failure,
        failure: failure,
      ),
      onRight: (name) => state.copyWith(
        locationStatus: RequestStatus.success,
        location: name,
        clearFailure: true,
      ),
    );
  }
}