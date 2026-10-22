abstract final class LocationEndpoints {
  static const String _prefix = 'Geography';

  static const String getAllCountries = '$_prefix/Country/GetAll';
  static String getGovernoratesByCountryId(String countryId) =>
      '$_prefix/Governorate/GetByCountryId/$countryId';
  static String getCitiesByGovernorateId(String governorateId) =>
      '$_prefix/City/GetByGovernorateId/$governorateId';
}