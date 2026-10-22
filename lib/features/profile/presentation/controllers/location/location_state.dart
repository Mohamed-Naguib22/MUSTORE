import 'package:equatable/equatable.dart';
import 'package:mustore/core/error/failure.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/features/profile/domain/entities/city.dart';
import 'package:mustore/features/profile/domain/entities/country.dart';
import 'package:mustore/features/profile/domain/entities/governorate.dart';

class LocationState extends Equatable {
  const LocationState({
    this.countriesStatus = RequestStatus.initial,
    this.governoratesStatus = RequestStatus.initial,
    this.citiesStatus = RequestStatus.initial,
    this.countries = const [],
    this.governorates = const [],
    this.cities = const [],
    this.selectedCountry,
    this.selectedGovernorate,
    this.selectedCity,
    this.failure,
  });

  final RequestStatus countriesStatus;
  final RequestStatus governoratesStatus;
  final RequestStatus citiesStatus;
  final List<Country> countries;
  final List<Governorate> governorates;
  final List<City> cities;
  final Country? selectedCountry;
  final Governorate? selectedGovernorate;
  final City? selectedCity;
  final Failure? failure;

  LocationState copyWith({
    RequestStatus? countriesStatus,
    RequestStatus? governoratesStatus,
    RequestStatus? citiesStatus,
    List<Country>? countries,
    List<Governorate>? governorates,
    List<City>? cities,
    Country? selectedCountry,
    Governorate? selectedGovernorate,
    City? selectedCity,
    Failure? failure,
    bool clearSelectedCountry = false,
    bool clearSelectedGovernorate = false,
    bool clearSelectedCity = false,
    bool clearFailure = false,
  }) =>
      LocationState(
        countriesStatus: countriesStatus ?? this.countriesStatus,
        governoratesStatus: governoratesStatus ?? this.governoratesStatus,
        citiesStatus: citiesStatus ?? this.citiesStatus,
        countries: countries ?? this.countries,
        governorates: governorates ?? this.governorates,
        cities: cities ?? this.cities,
        selectedCountry: clearSelectedCountry
            ? null
            : (selectedCountry ?? this.selectedCountry),
        selectedGovernorate: clearSelectedGovernorate
            ? null
            : (selectedGovernorate ?? this.selectedGovernorate),
        selectedCity:
        clearSelectedCity ? null : (selectedCity ?? this.selectedCity),
        failure: clearFailure ? null : (failure ?? this.failure),
      );

  @override
  List<Object?> get props => [
    countriesStatus,
    governoratesStatus,
    citiesStatus,
    countries,
    governorates,
    cities,
    selectedCountry,
    selectedGovernorate,
    selectedCity,
    failure,
  ];
}