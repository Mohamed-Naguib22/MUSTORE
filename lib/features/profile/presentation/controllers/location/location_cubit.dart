import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mustore/core/use_case/use_case.dart';
import 'package:mustore/core/utils/enums/request_status.dart';
import 'package:mustore/core/utils/mixins/safe_emit_mixin.dart';
import 'package:mustore/features/lookup/domain/use_cases/get_lookups_use_case.dart';
import 'package:mustore/features/profile/domain/entities/city.dart';
import 'package:mustore/features/profile/domain/entities/country.dart';
import 'package:mustore/features/profile/domain/entities/governorate.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState>
    with SafeEmitMixin<LocationState> {
  LocationCubit({
    required GetLookupsUseCase<NoParams> getCountries,
    required GetLookupsUseCase<String> getGovernorates,
    required GetLookupsUseCase<String> getCities,
  })  : _getCountries = getCountries,
        _getGovernorates = getGovernorates,
        _getCities = getCities,
        super(const LocationState());

  final GetLookupsUseCase<NoParams> _getCountries;
  final GetLookupsUseCase<String> _getGovernorates;
  final GetLookupsUseCase<String> _getCities;

  Future<void> fetchCountries({
    String? countryId,
    String? governorateId,
    String? cityId,
  }) async {
    if (state.countriesStatus.isLoading) return;

    safeEmit(
      state.copyWith(
        countriesStatus: RequestStatus.loading,
        clearFailure: true,
      ),
    );

    final result = await _getCountries(const NoParams());

    final countries = result.fold<List<Country>?>(
          (failure) {
        safeEmit(
          state.copyWith(
            countriesStatus: RequestStatus.failure,
            failure: failure,
          ),
        );
        return null;
      },
          (data) => data,
    );
    if (countries == null) return;

    Country? initial;
    if (countries.length == 1) {
      initial = countries.first;
    } else if (countryId != null) {
      for (final c in countries) {
        if (c.id == countryId) {
          initial = c;
          break;
        }
      }
    }

    safeEmit(
      state.copyWith(
        countriesStatus: RequestStatus.success,
        countries: countries,
        selectedCountry: initial,
        clearFailure: true,
      ),
    );

    if (initial != null) {
      await _loadGovernorates(
        initial,
        governorateId: governorateId,
        cityId: cityId,
      );
    }
  }

  Future<void> selectCountry(Country? country) async {
    safeEmit(
      state.copyWith(
        selectedCountry: country,
        clearSelectedCountry: country == null,
        clearSelectedGovernorate: true,
        clearSelectedCity: true,
        governorates: const [],
        cities: const [],
        governoratesStatus: RequestStatus.initial,
        citiesStatus: RequestStatus.initial,
        clearFailure: true,
      ),
    );

    if (country == null) return;
    await _loadGovernorates(country);
  }

  Future<void> selectGovernorate(Governorate? governorate) async {
    safeEmit(
      state.copyWith(
        selectedGovernorate: governorate,
        clearSelectedGovernorate: governorate == null,
        clearSelectedCity: true,
        cities: const [],
        citiesStatus: RequestStatus.initial,
        clearFailure: true,
      ),
    );

    if (governorate == null) return;
    await _loadCities(governorate);
  }

  void selectCity(City? city) => safeEmit(
    state.copyWith(selectedCity: city, clearSelectedCity: city == null),
  );

  Future<void> _loadGovernorates(
      Country country, {
        String? governorateId,
        String? cityId,
      }) async {
    safeEmit(state.copyWith(governoratesStatus: RequestStatus.loading));

    final result = await _getGovernorates(country.id);

    if (state.selectedCountry?.id != country.id) return;

    final governorates = result.fold<List<Governorate>?>(
          (failure) {
        safeEmit(
          state.copyWith(
            governoratesStatus: RequestStatus.failure,
            failure: failure,
          ),
        );
        return null;
      },
          (data) => data,
    );
    if (governorates == null) return;

    Governorate? initial;
    if (governorateId != null) {
      for (final g in governorates) {
        if (g.id == governorateId) {
          initial = g;
          break;
        }
      }
    }

    safeEmit(
      state.copyWith(
        governoratesStatus: RequestStatus.success,
        governorates: governorates,
        selectedGovernorate: initial,
        clearFailure: true,
      ),
    );

    if (initial != null) await _loadCities(initial, cityId: cityId);
  }

  Future<void> _loadCities(Governorate governorate, {String? cityId}) async {
    safeEmit(state.copyWith(citiesStatus: RequestStatus.loading));

    final result = await _getCities(governorate.id);

    if (state.selectedGovernorate?.id != governorate.id) return;

    final cities = result.fold<List<City>?>(
          (failure) {
        safeEmit(
          state.copyWith(
            citiesStatus: RequestStatus.failure,
            failure: failure,
          ),
        );
        return null;
      },
          (data) => data,
    );
    if (cities == null) return;

    City? initial;
    if (cityId != null) {
      for (final c in cities) {
        if (c.id == cityId) {
          initial = c;
          break;
        }
      }
    }

    safeEmit(
      state.copyWith(
        citiesStatus: RequestStatus.success,
        cities: cities,
        selectedCity: initial,
        clearFailure: true,
      ),
    );
  }

  void reset() => safeEmit(const LocationState());
}