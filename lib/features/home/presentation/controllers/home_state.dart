part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.locationStatus = RequestStatus.initial,
    this.location,
    this.failure,
  });

  final RequestStatus locationStatus;
  final String? location;
  final Failure? failure;

  HomeState copyWith({
    RequestStatus? locationStatus,
    String? location,
    Failure? failure,
    bool clearFailure = false,
  }) {
    return HomeState(
      locationStatus: locationStatus ?? this.locationStatus,
      location: location ?? this.location,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  @override
  List<Object?> get props => [locationStatus, location, failure];
}